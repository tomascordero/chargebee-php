module ChargeBee
  class Result

    def initialize(response)
      @response = response
    end
    
    def subscription() 
        get(:subscription, Subscription, 
        {:addons => Subscription::Addon, :coupons => Subscription::Coupon, :shipping_address => Subscription::ShippingAddress});
    end

    def customer() 
        get(:customer, Customer, 
        {:billing_address => Customer::BillingAddress, :payment_method => Customer::PaymentMethod});
    end

    def card() 
        get(:card, Card);
    end

    def invoice() 
        get(:invoice, Invoice, 
        {:line_items => Invoice::LineItem, :discounts => Invoice::Discount, :taxes => Invoice::Tax, :invoice_transactions => Invoice::LinkedTransaction, :applied_credits => Invoice::AppliedCredit, :created_credits => Invoice::CreatedCreditNote, :orders => Invoice::LinkedOrder, :invoice_notes => Invoice::Note, :shipping_address => Invoice::ShippingAddress, :billing_address => Invoice::BillingAddress});
    end

    def credit_note() 
        get(:credit_note, CreditNote, 
        {:line_items => CreditNote::LineItem, :discounts => CreditNote::Discount, :taxes => CreditNote::Tax, :credit_note_transactions => CreditNote::LinkedTransaction, :applied_credits => CreditNote::Allocation});
    end

    def order() 
        get(:order, Order);
    end

    def transaction() 
        get(:transaction, Transaction, 
        {:invoice_transactions => Transaction::LinkedInvoice, :credit_note_transactions => Transaction::LinkedCreditNote});
    end

    def hosted_page() 
        get(:hosted_page, HostedPage);
    end

    def estimate() 
      estimate = get(:estimate, Estimate, {}, {:invoice_estimate => InvoiceEstimate});
  		estimate.init_dependant(@response[:estimate], :invoice_estimate, 
      {:line_items => InvoiceEstimate::LineItem, :discounts => InvoiceEstimate::Discount, :taxes => InvoiceEstimate::Tax});
  		return estimate;
    end

    def estimates() 
      return get_list(:estimates, Estimate, {}, {:invoice_estimate => InvoiceEstimate},
      {:invoice_estimate => {:line_items => InvoiceEstimate::LineItem, :discounts => InvoiceEstimate::Discount, :taxes => InvoiceEstimate::Tax}});
    end    

    def plan() 
        get(:plan, Plan);
    end

    def addon() 
        get(:addon, Addon);
    end

    def coupon() 
        get(:coupon, Coupon);
    end

    def coupon_code() 
        get(:coupon_code, CouponCode);
    end

    def address() 
        get(:address, Address);
    end

    def event() 
        get(:event, Event);
    end

    def comment() 
        get(:comment, Comment);
    end

    def download() 
        get(:download, Download);
    end

    def portal_session() 
        get(:portal_session, PortalSession, 
        {:linked_customers => PortalSession::LinkedCustomer});
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
      # if(@response[type] != nil)
      #
      # end
          
      return klass.construct(@response[type], sub_types, dependant_types)
      
      # if(!array_key_exists($type, $this->_response))
      # {
      #           return null;
      # }
      #           if(!array_key_exists($type, $this->_responseObj))
      #           {
      #   $setVal = array();
      #   foreach($this->_response[$type] as $stV)
      #   {
      #     $obj = new $class($stV, $subTypes, $dependantTypes);
      #     foreach($dependantSubTypes as $k => $v)
      #     {
      #       $obj->_initDependant($stV, $k, $v);
      #     }
      #     array_push($setVal, $obj);
      #   }
      #   $this->_responseObj[$type] = $setVal;
      #           }
      #           return $this->_responseObj[$type];
      #
    end

  end
end
