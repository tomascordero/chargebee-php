require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
ChargeBee.verify_ca_certs=(false)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test", 
  :api_key => "test___dev__nT9OODXcYvFqWpVkcd5n01J3RaE52fkhf")

result = result = ChargeBee::Subscription.create({ :plan_id => "no_trial",
                                                   :affiliate_token => "1234",
                                                   :created_from_ip =>"192.168.1.1" });


subscription = result.subscription
customer = result.customer
card = result.card

print subscription
print customer

