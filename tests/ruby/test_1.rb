require '../../ruby/lib/chargebee'
$ENV_PROTOCOL = "https"
$CHARGEBEE_DOMAIN = "chargebee.com"
ChargeBee.configure(
    :site=> "abi-its-me-test",
    :api_key => "test_cuNpCAs2R1CwDySKDjyS5d5aKWh0MWitm"
)
ChargeBee.verify_ca_certs=(true)

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
update_plan
