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
        return $this->_get('subscription', 'ChargeBee_Subscription', 
        array('addons' => 'ChargeBee_SubscriptionAddon', 'coupons' => 'ChargeBee_SubscriptionCoupon', 'shipping_address' => 'ChargeBee_SubscriptionShippingAddress'));
    }

    function customer() 
    {
        return $this->_get('customer', 'ChargeBee_Customer', 
        array('billing_address' => 'ChargeBee_CustomerBillingAddress', 'payment_method' => 'ChargeBee_CustomerPaymentMethod'));
    }

    function card() 
    {
        return $this->_get('card', 'ChargeBee_Card');
    }

    function invoice() 
    {
        return $this->_get('invoice', 'ChargeBee_Invoice', 
        array('line_items' => 'ChargeBee_InvoiceLineItem', 'discounts' => 'ChargeBee_InvoiceDiscount', 'taxes' => 'ChargeBee_InvoiceTax', 'invoice_transactions' => 'ChargeBee_InvoiceLinkedTransaction', 'applied_credits' => 'ChargeBee_InvoiceAppliedCredit', 'created_credits' => 'ChargeBee_InvoiceCreatedCreditNote', 'orders' => 'ChargeBee_InvoiceLinkedOrder', 'invoice_notes' => 'ChargeBee_InvoiceNote', 'shipping_address' => 'ChargeBee_InvoiceShippingAddress', 'billing_address' => 'ChargeBee_InvoiceBillingAddress'));
    }

    function invoices() 
	{
        return $this->_getList('invoices', 'ChargeBee_Invoice', 
        array('line_items' => 'ChargeBee_InvoiceLineItem', 'discounts' => 'ChargeBee_InvoiceDiscount', 'taxes' => 'ChargeBee_InvoiceTax', 'invoice_transactions' => 'ChargeBee_InvoiceLinkedTransaction', 'applied_credits' => 'ChargeBee_InvoiceAppliedCredit', 'created_credits' => 'ChargeBee_InvoiceCreatedCreditNote', 'orders' => 'ChargeBee_InvoiceLinkedOrder', 'invoice_notes' => 'ChargeBee_InvoiceNote', 'shipping_address' => 'ChargeBee_InvoiceShippingAddress', 'billing_address' => 'ChargeBee_InvoiceBillingAddress'));
	}
	
    function creditNote() 
    {
        return $this->_get('credit_note', 'ChargeBee_CreditNote', 
        array('line_items' => 'ChargeBee_CreditNoteLineItem', 'discounts' => 'ChargeBee_CreditNoteDiscount', 'taxes' => 'ChargeBee_CreditNoteTax', 'credit_note_transactions' => 'ChargeBee_CreditNoteLinkedTransaction', 'applied_credits' => 'ChargeBee_CreditNoteAllocation'));
    }

    function order() 
    {
        return $this->_get('order', 'ChargeBee_Order');
    }

    function transaction() 
    {
        return $this->_get('transaction', 'ChargeBee_Transaction', 
        array('invoice_transactions' => 'ChargeBee_TransactionLinkedInvoice', 'credit_note_transactions' => 'ChargeBee_TransactionLinkedCreditNote'));
    }

    function hostedPage() 
    {
        $hostedPage = $this->_get('hosted_page', 'ChargeBee_HostedPage');
		return $hostedPage;
    }

    function estimate()
    {
		$estimate = $this->_get('estimate', 'ChargeBee_Estimate', array(), array('invoice_estimate' => 'ChargeBee_InvoiceEstimate'));
		$estimate->_initDependant($this->_response['estimate'], 'invoice_estimate', array('line_items' => 'ChargeBee_InvoiceEstimateLineItem', 'discounts' => 'ChargeBee_InvoiceEstimateDiscount', 'taxes' => 'ChargeBee_InvoiceEstimateTax'));
		
		$estimate = $this->_get('estimate', 'ChargeBee_Estimate', array(), array('invoice_estimates' => 'ChargeBee_InvoiceEstimate'));
		$estimate->_initDependantList($this->_response['estimate'], 'invoice_estimates', array('line_items' => 'ChargeBee_InvoiceEstimateLineItem', 'discounts' => 'ChargeBee_InvoiceEstimateDiscount', 'taxes' => 'ChargeBee_InvoiceEstimateTax'));
		return $estimate;
    }
	
    function estimates() 
    {
		return $this->_getList('estimates', 'ChargeBee_Estimate', array(), array('invoice_estimate' => 'ChargeBee_InvoiceEstimate'),
		array('invoice_estimate'=>array('line_items' => 'ChargeBee_InvoiceEstimateLineItem', 'discounts' => 'ChargeBee_InvoiceEstimateDiscount', 'taxes' => 'ChargeBee_InvoiceEstimateTax')));
    }

    function plan() 
    {
        return $this->_get('plan', 'ChargeBee_Plan');
    }

    function addon() 
    {
        return $this->_get('addon', 'ChargeBee_Addon');
    }

    function coupon() 
    {
        return $this->_get('coupon', 'ChargeBee_Coupon');
    }

    function couponCode() 
    {
        return $this->_get('coupon_code', 'ChargeBee_CouponCode');
    }

    function address() 
    {
        return $this->_get('address', 'ChargeBee_Address');
    }

    function event() 
    {
        return $this->_get('event', 'ChargeBee_Event');
    }

    function comment() 
    {
        return $this->_get('comment', 'ChargeBee_Comment');
    }

    function download() 
    {
        return $this->_get('download', 'ChargeBee_Download');
    }

    function portalSession() 
    {
        return $this->_get('portal_session', 'ChargeBee_PortalSession', 
        array('linked_customers' => 'ChargeBee_PortalSessionLinkedCustomer'));
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