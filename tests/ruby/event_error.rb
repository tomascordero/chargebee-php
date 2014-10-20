# encoding: utf-8

# Require the chargebee-ruby library directory that is relative
# to your chargebee-app directory.
require '../../ruby/lib/chargebee'
require 'json'

#Use the below settings code to connect the library with the
#local server
#$CHARGEBEE_DOMAIN = "freshdesk.com"
$CHARGEBEE_DOMAIN = "localcb.in:8080"

ChargeBee.configure(:site => "mannar-test", 
  :api_key => "test___dev__KScdxhX6cdv9BbJW3EayQcdxY3xjvcu3PHz")    

puts ChargeBee::Event.deserialize("{}")

