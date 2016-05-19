require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test", 
  :api_key => "test___dev__lo2w917cu5a6GxS3K4HfPFBM1zYP3URYc")

def create_plan
  begin
  list = ChargeBee::Plan.list({
  "price[between]" => [900,1900]
})
list.each do |entry|
  puts entry.plan.id
end
  rescue Exception => e
      puts e
  end
end


create_plan
