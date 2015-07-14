require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test", 
  :api_key => "test___dev__ZULS5m2AJ2GTJgQJIcd4OecuDcddpFv4tTt")

def checkout_new
 result = ChargeBee::HostedPage.checkout_new({
  :subscription => {
    :plan_id => "enterprise_half_yearly"
  }, 
  :customer => {
    :email => "john@user.com", 
    :first_name => "John", 
    :last_name => "Doe", 
    :phone => "+1-949-999-9999"
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



create_plan
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
