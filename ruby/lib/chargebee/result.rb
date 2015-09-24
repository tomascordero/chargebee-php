module ChargeBee
  class Result

    def initialize(response)
      @response = response
    end
    
    def subscription() 
        subscription = get(:subscription, Subscription,
        {:addons => Subscription::Addon, :coupons => Subscription::Coupon, :shipping_address => Subscription::ShippingAddress});
        return subscription;
    end

    def customer() 
        customer = get(:customer, Customer,
        {:billing_address => Customer::BillingAddress, :payment_method => Customer::PaymentMethod});
        return customer;
    end

    def card() 
        card = get(:card, Card);
        return card;
    end

    def invoice() 
        invoice = get(:invoice, Invoice,
        {:line_items => Invoice::LineItem, :discounts => Invoice::Discount, :taxes => Invoice::Tax, :invoice_transactions => Invoice::LinkedTransaction, :orders => Invoice::LinkedOrder, :invoice_notes => Invoice::Note, :shipping_address => Invoice::ShippingAddress, :billing_address => Invoice::BillingAddress});
        return invoice;
    end

    def order() 
        order = get(:order, Order);
        return order;
    end

    def transaction() 
        transaction = get(:transaction, Transaction,
        {:invoice_transactions => Transaction::LinkedInvoice});
        return transaction;
    end

    def hosted_page() 
        hosted_page = get(:hosted_page, HostedPage);
        return hosted_page;
    end

    def estimate() 
        estimate = get(:estimate, Estimate,
        {:line_items => Estimate::LineItem, :discounts => Estimate::Discount, :taxes => Estimate::Tax});
        return estimate;
    end

    def plan() 
        plan = get(:plan, Plan);
        return plan;
    end

    def addon() 
        addon = get(:addon, Addon);
        return addon;
    end

    def coupon() 
        coupon = get(:coupon, Coupon);
        return coupon;
    end

    def coupon_code() 
        coupon_code = get(:coupon_code, CouponCode);
        return coupon_code;
    end

    def address() 
        address = get(:address, Address);
        return address;
    end

    def event() 
        event = get(:event, Event,
        {:webhooks => Event::Webhook});
        return event;
    end

    def comment() 
        comment = get(:comment, Comment);
        return comment;
    end

    def download() 
        download = get(:download, Download);
        return download;
    end

    def portal_session() 
        portal_session = get(:portal_session, PortalSession,
        {:linked_customers => PortalSession::LinkedCustomer});
        return portal_session;
    end



    def to_s(*args) 
      JSON.pretty_generate(@response) 
    end

    private
    def get(type, klass, sub_types = {}, dependant_types = {})
      return klass.construct(@response[type], sub_types, dependant_types)
    end

    private
    def get_list(type, klass, sub_types = {}, dependant_types = {}, dependant_sub_types = {})
      if(@response[type] == nil)
        return nil
      end
      set_val = Array.new
      @response[type].each do |obj|
        case obj
        when Hash
          model = klass.construct(obj, sub_types, dependant_types)
          dependant_sub_types.each do |k,v|
        		model.init_dependant(obj, k, v);
          end
          set_val.push(model)
        end
      end
      return instance_variable_set("@#{type}", set_val)
    end

  end
end
