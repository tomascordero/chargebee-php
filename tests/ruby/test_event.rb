require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test",
  :api_key => "test___dev__qIOf7uXcI3vsR3DNNOelTWmF70W1yIUR")


file = File.new("./sample_event.json")
contents = file.read
#puts contents

event = ChargeBee::Event.deserialize(contents)
puts event
puts event.event_type
