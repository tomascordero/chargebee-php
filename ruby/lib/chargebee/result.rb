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
      
      #       estimate = get(:estimate, Estimate, {}, {:invoice_estimates => InvoiceEstimate});
      # estimate.init_dependant_list(@response[:estimate], :invoice_estimates,
      #       {:line_items => InvoiceEstimate::LineItem, :discounts => InvoiceEstimate::Discount, :taxes => InvoiceEstimate::Tax});
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
        get(:event, Event, 
        {:webhooks => Event::Webhook});
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
