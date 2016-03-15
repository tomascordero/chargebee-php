require '../../ruby/lib/chargebee.rb';
#$CHARGEBEE_DOMAIN = "localcb.in:8080"
$CHARGEBEE_DOMAIN = "stagingcb.com"
#ChargeBee.verify_ca_certs=(false)
$ENV_PROTOCOL = "https"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "stagingtesting-2", 
  :api_key => "live_WgIpp3D8cdcXcuJ20lihY0qlQ9xzrT1T8k")

def checkout_new
 result = ChargeBee::HostedPage.checkout_new({
  :subscription => {
    :plan_id => "no-trial"
  }, 
  :customer => {
    :email => "john@user.com", 
    :first_name => "John", 
    :last_name => "Doe", 
    :phone => "+1-949-999-9999"
    #:taxability => "exempt"
  },
  :embed => "false" 
 })
 puts result.hosted_page.url
end

def retrieve_customer_amazon_payment
  #result = ChargeBee::Customer.retrieve("1sGeZ2FOvHpO3Z2v");
  result = ChargeBee::Customer.retrieve("1sGeZ3FOvBeqLojW");
  puts result.customer.payment_method
  puts result.customer.payment_method.type
  puts result.customer.payment_method.reference_id
  puts result.customer.payment_method.status
end

def retrieve_customer_card
 begin
 # result = ChargeBee::Card.retrieve("1sGeZ2FOvHpO3Z2v")
  result = ChargeBee::Card.retrieve("1sGeZ3FOvBeqLojW")
  card = result.card
  puts card
 rescue ChargeBee::InvalidRequestError=> ex
  puts ex.api_error_code
 end
end

def retrieve_txn_amazon
 result = ChargeBee::Transaction.retrieve("txn_1sGeZ2FOvHzDwG4Y")
 #result = ChargeBee::Transaction.retrieve("txn_1sGeZ2FOvI530V5R")
 puts result.transaction
 puts result.transaction.payment_method 
end

def update_card_for_amazon
 result = ChargeBee::Card.update_card_for_customer("1sGeZ2FOvHpO3Z2v", {
  :gateway => "chargebee", 
  :first_name => "Richard", 
  :last_name => "Fox", 
  :number => "4012888888881881", 
  :expiry_month => 10, 
  :expiry_year => 2015, 
  :cvv => "999"
 })
 puts result
 puts result.customer
 puts result.card
 puts result.customer.payment_method
end

def test_state_code_shipping_add
  result = ChargeBee::Address.update({:subscription_id => "__dev__3Nl8FFOP4SU5mlB", 
              :label => "shipping_address",
              :first_name => "Benjamin",
              :last_name => "Ross",
              :addr => "PO BOX 999",
              :city => "chennai",
#              :state_code => "asdas",
              :state => "Tamil Nadu",
              :zip => "600059",
              :country => "IN"
   })
   puts result
end

def test_remove_schedule_cancelation
  result = ChargeBee::Subscription.remove_scheduled_cancellation("__dev__3Nl8FFOP4SU5mlB")
  puts result.subscription
  puts result.customer
  puts result.card  
end

def test_schedule_cancelation_event
   result = ChargeBee::Event.retrieve("ev___dev__3Nl8F4QP4WKmxY3")
   puts result.event
   puts result.event.event_type
   puts result.event.content
  
   result =  ChargeBee::Event.retrieve("ev___dev__3Nl8F4QP4WLLMO4")
   puts result.event
   puts result.event.event_type
   puts result.event.content
end

def test_billing_cycle_in_reactivate
  result = ChargeBee::Subscription.reactivate("__dev__3Nl8F4QP4WNeAf9", {"billing_cycles" => 0})
  puts result.subscription 
end

def test_state_code_billing_addr
   result = ChargeBee::Customer.update_billing_info("__dev__3Nl8FFOP4SU5mlB", {
       :billing_address => {
         :first_name => "John", 
         :last_name => "Doe", 
         :line1 => "PO Box 9999", 
         :city => "Walnut", 
         :state_code => "CA",
         #:state => "California", 
         #:zip => "91789", 
         #:country => "US"
    }
  })
  puts result.customer
  puts result.customer.billing_address
end

def test_state_code_card_addr
  result = ChargeBee::Card.update_card_for_customer("__dev__3Nl8F4QP4WQHnfZ", {
  :gateway => "chargebee", 
  :first_name => "Richard", 
  :last_name => "Fox", 
  :number => "4012888888881881", 
  :expiry_month => 10, 
  :expiry_year => 2015, 
  :cvv => "999",
  :billing_addr1 => "Line 1",
  :billing_state_code => "CA",
  :billing_country => "US"
})
puts result.customer
puts result.card
end

def test_linked_order
   begin
   result = ChargeBee::Order.create(:invoice_id => "__demo_inv__31", 
				    :status => "processing",
 				    :reference_id => "reference id",
				    :fulfillment_status => "Shipping", 
 				    :tracking_id => "tracking id",
 				    :note=>"It is a note", 
				    :batch_id => "batch id")
   puts result
   rescue Exception => e
      puts e
   end
   puts "Invoice"
   result = ChargeBee::Invoice.retrieve("__demo_inv__31")
   puts result 
   
end

def delete_invoice
  begin
   result = ChargeBee::Invoice.delete("7016")
 rescue Exception => e
     puts e
 end
 puts result
end

def test_accent_chars
  result = ChargeBee::Event.retrieve("ev___dev__KyVpAsPA7dZ2YJ")
  puts result
  name = result.event.content.customer.first_name
  puts name
end

def create_plan
 begin
result = ChargeBee::Plan.create({
  :id => "silver2",
  :name => "Silver2",
  :invoice_name => "sample plan",
  :price => 5000,
  :downgrade_penalty => 1
})
puts result.plan
rescue ChargeBee::InvalidRequestError=> ex
  puts ex.error_code
  puts ex.api_error_code
  puts ex.http_status_code
  #puts ex.error_msg
  puts ex.message
  puts ex.param
end
end

def update_plan
 begin
result = ChargeBee::Plan.update("silver", :invoice_name => "sample plan", :downgrade_penalty => "1")
puts result.plan
rescue ChargeBee::InvalidRequestError=> ex
  puts ex.error_code
  puts ex.api_error_code
  puts ex.http_status_code
  #puts ex.error_msg
  puts ex.message
  puts ex.param
end
end

def get_invoice
  result = ChargeBee::Invoice.retrieve("__demo_inv__32")
  puts result.invoice.dunning_status
  
  result1 = ChargeBee::Invoice.stop_dunning(result.invoice.id)
  puts result1.invoice.dunning_status
end


def create_customer
  result = ChargeBee::Customer.create({
     :first_name => "first_name",
     :taxability => "exempt"
  })
  puts result
end

def create_plan
  plan_name = "gold"
  result = ChargeBee::Plan.create({
         :id => plan_name,
         :name => plan_name,
         :price => 1000,
         :taxable => "yes"
  })
  puts result.plan.to_s
end

def update_plan_tax
   plan_name = "silver"
   result = ChargeBee::Plan.update(plan_name, { :invoice_name => "sample plan", :taxable => "no"})
   puts result.plan.to_s
end

def create_addon
  addon_name = "tax_addon"
  result = ChargeBee::Addon.create({
          :id => addon_name,
          :name => addon_name,
          :charge_type => "recurring",
          :price => "1000",
          :period => 1,
          :period_unit => "week",
          :type => "on_off",
          :taxable => "no"
  })
  puts result.addon.to_s
end

def update_addon
   addon_name = "tax_addon"
   result = ChargeBee::Addon.update(addon_name,{ :taxable => "yes"
   })
end

def create_sub
  result = ChargeBee::Subscription.create({
         :plan_id => "gold",
         :customer => {
                  :email => "email@email.com",
                  :taxability => "taxable",
                  :auto_collection => "off"
         },
  })
  puts result.to_s
end

def update_sub
  result = ChargeBee::Subscription.update("__dev__3Nl8H3wPOLhACA2l",{
  	:plan_id => "basic",
        :customer => {:taxable => "exempt" }
  })
  puts result.to_s
end

def create_sub_estimate
 result = ChargeBee::Estimate.create_subscription({
      :subscription => {
          :plan_id => "no-trial"
      }, 
      :addons => [{
         :id => "tax_addon"
      }]
    })
  puts result.to_s
end

def update_sub_estimate
 result = ChargeBee::Estimate.update_subscription({
  :subscription => {
    :id => "__dev__3Nl8H3wPOLkjUt4K", 
  }, 
 })
 puts result.to_s
end


def retrieve_plan
result = ChargeBee::Plan.retrieve("silver");
puts result.to_s
end

def retrieve_addon
result = ChargeBee::Addon.retrieve("tax_addon")
puts result.to_s
end

def retrieve_customer
  result = ChargeBee::Customer.retrieve("__dev__3Nl8GtQPPCCMhr1Y")
  puts result
  puts result.customer.card_status
end


def retrieve_event
  result = ChargeBee::Event.retrieve("ev___dev__3Nl8GtQPPCDukR23")
  puts result
  puts result.event.event_type
end

def retrieve_txn
  result = ChargeBee::Transaction.retrieve("txn___dev__3Nl8GtQPPCDu7H21")
  puts result
  puts result.transaction.status
  puts result.transaction.payment_method
  puts result.transaction.masked_card_number
end


def update_cust
  id=" "
  result = ChargeBee::Customer.update(id,{:first_name=>"John", :last_name=>"Doe"})
  print result.to_s 
end

def switch_gateway
  result = ChargeBee::Customer.retrieve("2sDt7UcmPfVvIJF5b");
  puts result
  result1 = ChargeBee::Card.switch_gateway("2sDt7UcmPfVvIJF5b", {:gateway => "eway_rapid"})
  puts result1
end


begin
switch_gateway
#update_cust
#retrieve_txn
#retrieve_event
#retrieve_customer
#update_sub
#create_sub
#update_addon
#create_addon
#update_plan_tax
#create_plan
#create_customer
#get_invoice
#create_plan
#update_plan
#test_accent_chars()
#delete_invoice
#test_linked_order()
#test_state_code_card_addr()
#test_state_code_billing_addr()
#test_billing_cycle_in_reactivate()
#test_schedule_cancelation_event()
#test_remove_schedule_cancelation()
#test_state_code_shipping_add()
#update_card_for_amazon
#retrieve_txn_amazon
#retrieve_customer_card
#retrieve_customer_amazon_payment
#checkout_new
#create_sub_estimate
#update_sub_estimate
#retrieve_plan
#retrieve_addon
rescue Exception => e
  puts e
end
