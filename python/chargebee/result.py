from chargebee.compat import json
from chargebee.models import *


class Result(object):

    def __init__(self, response):
        self._response = response
        self._response_obj = {}

    @property
    def subscription(self):
        return self._get('subscription', Subscription,
        {'addons' : Subscription.Addon, 'coupons' : Subscription.Coupon, 'shipping_address' : Subscription.ShippingAddress});

    @property
    def customer(self):
        return self._get('customer', Customer,
        {'billing_address' : Customer.BillingAddress, 'payment_method' : Customer.PaymentMethod});

    @property
    def card(self):
        return self._get('card', Card);

    @property
    def invoice(self):
        return self._get('invoice', Invoice,
        {'line_items' : Invoice.LineItem, 'discounts' : Invoice.Discount, 'taxes' : Invoice.Tax, 'invoice_transactions' : Invoice.LinkedTransaction, 'orders' : Invoice.LinkedOrder, 'invoice_notes' : Invoice.Note, 'shipping_address' : Invoice.ShippingAddress, 'billing_address' : Invoice.BillingAddress});

    @property
    def order(self):
        return self._get('order', Order);

    @property
    def transaction(self):
        return self._get('transaction', Transaction,
        {'invoice_transactions' : Transaction.LinkedInvoice});

    @property
    def hosted_page(self):
        return self._get('hosted_page', HostedPage);

    @property
    def estimate(self):
        # estimate = self._get('estimate', Estimate, {}, {'invoice_estimate' : InvoiceEstimate});
        # estimate.init_dependant(self._response['estimate'], 'invoice_estimate',
        # {'line_items' : InvoiceEstimate.LineItem, 'discounts' : InvoiceEstimate.Discount, 'taxes' : InvoiceEstimate.Tax});
        
        estimate = self._get('estimate', Estimate, {}, {'invoice_estimates' : InvoiceEstimate});
        estimate.init_dependant_list(self._response['estimate'], 'invoice_estimates',
        {'line_items' : InvoiceEstimate.LineItem, 'discounts' : InvoiceEstimate.Discount, 'taxes' : InvoiceEstimate.Tax});
        return estimate;

    @property
    def estimates(self):
        return self._get_list('estimates', Estimate, {}, {'invoice_estimate' : InvoiceEstimate}, {'invoice_estimate' :
        {'line_items' : InvoiceEstimate.LineItem, 'discounts' : InvoiceEstimate.Discount, 'taxes' : InvoiceEstimate.Tax}});

    @property
    def plan(self):
        return self._get('plan', Plan);

    @property
    def addon(self):
        return self._get('addon', Addon);

    @property
    def coupon(self):
        return self._get('coupon', Coupon);

    @property
    def coupon_code(self):
        return self._get('coupon_code', CouponCode);

    @property
    def address(self):
        return self._get('address', Address);

    @property
    def event(self):
        return self._get('event', Event);

    @property
    def comment(self):
        return self._get('comment', Comment);

    @property
    def download(self):
        return self._get('download', Download);

    @property
    def portal_session(self):
        return self._get('portal_session', PortalSession,
        {'linked_customers' : PortalSession.LinkedCustomer});


    def _get(self, type, cls, sub_types=None, dependant_types=None):
        if not type in self._response:
            return None

        if not type in self._response_obj:
            self._response_obj[type] = cls.construct(self._response[type], sub_types, dependant_types)

        return self._response_obj[type]

    def _get_list(self, type, cls, sub_types={}, dependant_types={}, dependant_sub_types={}):
        if not type in self._response:
            return None
        
        set_val = []
        for obj in self._response[type]:
            if isinstance(obj, dict):
                model = cls.construct(obj, sub_types, dependant_types)
                for k in dependant_sub_types:
                    model.init_dependant(obj, k, dependant_sub_types[k])
                    set_val.append(model)

        self._response_obj[type] = set_val
        return self._response_obj[type]
    
    def __str__(self):
        return json.dumps(self._response, indent=4)


class Content(Result):
    pass
