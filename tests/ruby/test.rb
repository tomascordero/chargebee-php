require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"


#Code from apidocs
ChargeBee.configure(:site => "mannar-test", 
  :api_key => "__dev__YlRMjamvRnwhK8sDYN8miacuJSpSH3EfK")
result = ChargeBee::Subscription.retrieve("active_direct")
subscription = result.subscription
customer = result.customer
card = result.card


#Test
print result.customer.billing_address.country

