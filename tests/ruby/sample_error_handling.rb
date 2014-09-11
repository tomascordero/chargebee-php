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

ChargeBee.verify_ca_certs=(false)

begin
result = ChargeBee::Subscription.create({
  :plan_id => "no_trial", 
  :coupon => "ss",
  :customer => {
    :email => "john@user.com", 
    :first_name => "John", 
    :last_name => "Doe", 
    :phone => "+1-949-999-9999"
  }, 
  :billing_address => {
    :first_name => "John", 
    :last_name => "Doe", 
    :line1 => "PO Box 9999", 
    :city => "Walnut", 
    :state => "CA", 
    :zip => "91789", 
    :country => "US"
  }, 
  :card =>  {
  :gateway => "chargebee", 
  :first_name => "Richard", 
  :last_name => "Fox", 
  :number => "4012888888881881", 
  :expiry_month => 10, 
  :expiry_year => 2015, 
  :cvv => "999"
},
  :addons => [{
    :id => "ssl"
  }]
})
    subscription = result.subscription
    puts result
rescue ChargeBee::PaymentError=> ex
    # First check for user inputted card parameters and show appropriate message.
    # We recommend you to validate the input at the client side itself to catch simple mistakes.
    if "card[number]" == ex.param
      puts "Card number error #{ex.api_error_code}" 
      # Ask your user to recheck the card number. A better way is to use 
      # Stripe's https:#github.com/stripe/jquery.payment for validating it in the client side itself.         
    else
      puts "Other errors #{ex.api_error_code}" 
      # Provide a standard message to your user to recheck his card details or provide a different card.
      # Like  'Sorry,there was a problem when processing your card, please check the details and try again'. 
    end 
rescue ChargeBee::InvalidRequestError=> ex
    # For coupons you could decide to provide specific messages by using 
    # the 'code' attribute in the ex.
    if "coupon" == ex.param
      if "resource_not_found" == ex.api_error_code
        puts "Resource not found #{ex.api_error_code} #{ex}" 
        # Inform user to recheck his coupon code.
        
      elsif "resource_limit_exhausted" == ex.api_error_code
        # Inform user that the coupon code has expired.
        
      elsif  "invalid_request" == ex.api_error_code
        # Inform user that the coupon code is not applicable for his plan(/addons).
        
      else
        # Inform user to recheck his coupon code.
      end  
    else
      # Since you would have validated all other parameters on your side itself, 
      # this could probably be a bug in your code. Provide a generic message to your users.
    end      
rescue ChargeBee::OperationFailedError=> ex
    puts "Operation failed #{ex.api_error_code} #{ex}" 
    # Indicates that the request parameters were right but the request couldn't be completed.
    # The reasons might be "api_request_limit_exceeded" or could be due to an issue in ChargeBee side.
    # These should occur very rarely and mostly be of temporary nature. 
    # You could ask your user to retry after some time.
        
rescue ChargeBee::APIError=> ex
   puts "APIError Error #{ex}" 
   # Handle the other ChargeBee API errors. Mostly would be setup related 
   # Errors such as authentication failure.
   # You could ask users contact your support.

rescue ChargeBee::IOError => ex       
   puts "Http Error #{ex}" 
   puts ex.original_error
   # Handle IO exceptions such as connection timeout, request timeout etc.
   # You could give a generic message to the customer retry after some time.
 
   # If required, you could access the underling error using ex.original_error
   
rescue Exception => ex
   puts "General exception #{ex.class.name}  #{ex}"
   puts ex.backtrace
   # These are unhandled exceptions (Could be due to a bug in your code or very rarely in client library).
   # You could ask users contact your support.
end   

