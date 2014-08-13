require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
ChargeBee.verify_ca_certs=(false)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test", 
  :api_key => "test___dev__dJIiuf4qr6gcuTiPLiBSY1Zm40o4vcdFAT")

result = ChargeBee::Subscription.retrieve("active_direct")
subscription = result.subscription
customer = result.customer
card = result.card

print customer.cf_about_yourself
print customer.asdas

