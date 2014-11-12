require '../../ruby/lib/chargebee.rb';
#$CHARGEBEE_DOMAIN = "localcb.in:8080"
$CHARGEBEE_DOMAIN = "stagingcb.com"
$ENV_PROTOCOL = "https"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "stagingtesting-2-test", 
  :api_key => "test_b8Zsv1ZhzEIbumcdrijvPC1Nj4q1ZREoq")

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

update_card_for_amazon
#retrieve_txn_amazon
#retrieve_customer_card
#retrieve_customer_amazon_payment
#checkout_new
