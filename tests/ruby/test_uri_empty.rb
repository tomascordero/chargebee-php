require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test",
  :api_key => "test___dev__cuwdrqzezGcuMOcL44LvcdWiyccdOkizHuAX")


#result = ChargeBee::Subscription.update("api_sub_create_1", {:plan_id => "no_trial"})
id= "__dev__3Nl8GwLPT2putC4"
#id= "  "
#id = nil
#if id.strip.empty?
#    puts "empty"
#end
result = ChargeBee::Subscription.retrieve(id)
puts result


list = ChargeBee::Subscription.subscriptions_for_customer(id)
list.each do |entry|
  subscription = entry.subscription
  puts subscription
end
