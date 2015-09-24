<?php

class ChargeBee_Result
{
    private $_response;
	
    private $_responseObj;

    function __construct($_response)
    {
            $this->_response = $_response;
            $this->_responseObj = array();
    }

    function subscription() 
    {
        $subscription = $this->_get('subscription', 'ChargeBee_Subscription', 
        array('addons' => 'ChargeBee_SubscriptionAddon', 'coupons' => 'ChargeBee_SubscriptionCoupon', 'shipping_address' => 'ChargeBee_SubscriptionShippingAddress'));
        return $subscription;
    }

    function customer() 
    {
        $customer = $this->_get('customer', 'ChargeBee_Customer', 
        array('billing_address' => 'ChargeBee_CustomerBillingAddress', 'payment_method' => 'ChargeBee_CustomerPaymentMethod'));
        return $customer;
    }

    function card() 
    {
        $card = $this->_get('card', 'ChargeBee_Card');
        return $card;
    }

    function invoice() 
    {
        $invoice = $this->_get('invoice', 'ChargeBee_Invoice', 
        array('line_items' => 'ChargeBee_InvoiceLineItem', 'discounts' => 'ChargeBee_InvoiceDiscount', 'taxes' => 'ChargeBee_InvoiceTax', 'invoice_transactions' => 'ChargeBee_InvoiceLinkedTransaction', 'orders' => 'ChargeBee_InvoiceLinkedOrder', 'invoice_notes' => 'ChargeBee_InvoiceNote', 'shipping_address' => 'ChargeBee_InvoiceShippingAddress', 'billing_address' => 'ChargeBee_InvoiceBillingAddress'));
        return $invoice;
    }

    function order() 
    {
        $order = $this->_get('order', 'ChargeBee_Order');
        return $order;
    }

    function transaction() 
    {
        $transaction = $this->_get('transaction', 'ChargeBee_Transaction', 
        array('invoice_transactions' => 'ChargeBee_TransactionLinkedInvoice'));
        return $transaction;
    }

    function hostedPage() 
    {
        $hosted_page = $this->_get('hosted_page', 'ChargeBee_HostedPage');
        return $hosted_page;
    }

    function estimate() 
    {
        $estimate = $this->_get('estimate', 'ChargeBee_Estimate', 
        array('line_items' => 'ChargeBee_EstimateLineItem', 'discounts' => 'ChargeBee_EstimateDiscount', 'taxes' => 'ChargeBee_EstimateTax'));
        return $estimate;
    }

    function plan() 
    {
        $plan = $this->_get('plan', 'ChargeBee_Plan');
        return $plan;
    }

    function addon() 
    {
        $addon = $this->_get('addon', 'ChargeBee_Addon');
        return $addon;
    }

    function coupon() 
    {
        $coupon = $this->_get('coupon', 'ChargeBee_Coupon');
        return $coupon;
    }

    function couponCode() 
    {
        $coupon_code = $this->_get('coupon_code', 'ChargeBee_CouponCode');
        return $coupon_code;
    }

    function address() 
    {
        $address = $this->_get('address', 'ChargeBee_Address');
        return $address;
    }

    function event() 
    {
        $event = $this->_get('event', 'ChargeBee_Event', 
        array('webhooks' => 'ChargeBee_EventWebhook'));
        return $event;
    }

    function comment() 
    {
        $comment = $this->_get('comment', 'ChargeBee_Comment');
        return $comment;
    }

    function download() 
    {
        $download = $this->_get('download', 'ChargeBee_Download');
        return $download;
    }

    function portalSession() 
    {
        $portal_session = $this->_get('portal_session', 'ChargeBee_PortalSession', 
        array('linked_customers' => 'ChargeBee_PortalSessionLinkedCustomer'));
        return $portal_session;
    }

    

    private function _get($type, $class, $subTypes = array(), $dependantTypes = array())
    {
        if(!array_key_exists($type, $this->_response))
        {
            return null;
        }
        if(!array_key_exists($type, $this->_responseObj))
        {
            $this->_responseObj[$type] = new $class($this->_response[$type], $subTypes, $dependantTypes);
        }
        return $this->_responseObj[$type];
    }

    private function _getList($type, $class, $subTypes = array(), $dependantTypes = array(),  $dependantSubTypes = array())
    {
        if(!array_key_exists($type, $this->_response))
        {
            return null;
        }
        if(!array_key_exists($type, $this->_responseObj))
        {
            $setVal = array();
            foreach($this->_response[$type] as $stV)
            {
                $obj = new $class($stV, $subTypes, $dependantTypes);
                foreach($dependantSubTypes as $k => $v)
                {
                    $obj->_initDependant($stV, $k, $v);
                }
                array_push($setVal, $obj);
            }
            $this->_responseObj[$type] = $setVal;
        }
        return $this->_responseObj[$type];        
    }
    
}

?>