# Require the chargebee-ruby library directory that is relative
# to your chargebee-app directory.
require '../../../chargebee-ruby/lib/chargebee'
require 'json'

#Use the below settings code to connect the library with the
#local server
$CHARGEBEE_DOMAIN = "localcb.in:8080"
ChargeBee.configure({
    :site=> 'mannar-test', #'rrcb-test',
    :api_key => "test___dev__NqcddV3mrcu9pWqcyacuq0twyYyXXPrVlcuj"
})
ChargeBee.verify_ca_certs=(false)

def print_errors(e)
  error_obj = e.json_obj
  puts "OLD ERRORS"
  puts e.http_code
  puts e.error_code
  puts e.json_obj[:error_param]
  puts "NEW ERRORS" 
  puts error_obj[:api_error_code]
  puts e.json_obj[:type]
  puts e.param
  puts e.json_obj[:message]
end

def create_sub
 begin
  result = ChargeBee::Subscription.create({
    :plan_id => "flat_fee",
    :plan_quantity => "3", 
    :customer => {
       :email => "john@user.com", 
       :first_name => "John asdsakdj kbdksbak asjbdkasd askbdksjad asdkbaskjd asdbjaskjd kdbksa asjkdbasd askbdkasb asdkbasjkda askdbaksd kasbdaskd kbasdjbsdaskb jkabdsksab asdbaskdsa absdksba asdbaskd asddasdaskd kabdaksbd asdkbsakdd asdkbsak asdbkasbdn kamsbdbd askdbsa sakbdasd  kbdasbas kandasn kasdkjsab askdkasd", 
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
    :addons => [{
      :id => "ssl"
    }]
  })
 puts result.to_s
 rescue ChargeBee::APIError => e
  print_errors(e)
 end
end

def update_sub
  begin
    result = ChargeBee::Subscription.update("__dev__XpbG8HXOpwFKebU",{
       :plan_id => "flat_fee", 
       #:plan_quantity => "2",
       :coupon => "plan_only_coupon",       
       :billing_address => {
         :first_name => "John", 
         :last_name => "Doe", 
         :line1 => "PO Box 9999", 
         :city => "Walnut", 
         :state => "CA", 
         :zip => "91789", 
         :country => "US"
      }, 
      :addons => [{
        :id => "ssl"
      }]
    })
   puts result
  rescue ChargeBee::APIError => e
   print_errors(e)
  end
end


def hosted_page
  begin
    result = ChargeBee::HostedPage.checkout_new({
       :subscription => {
         :plan_id => "basic",
         :coupon => "plan_only_coupon"
     }, 
    :customer => {
      :email => "john@user.com", 
      :first_name => "John", 
      :last_name => "Doe", 
      :phone => "+1-949-999-9999"
    }, 
    :addons => [{
      :id => "ssl"
     }]
   })
  rescue ChargeBee::APIError => e
    print_errors(e)
  end
end


def checkout_existing
 begin
    result = ChargeBee::HostedPage.checkout_existing({
        :subscription => {
           :id => "future_billing", 
           :plan_id => "basic"
     }, 
     :addons => [{
          :id => "ssl"
     }]
   })
   puts result
  rescue ChargeBee::APIError => e
    print_errors(e)
  end
end

def create_invoice_for_charge
  begin
  result = ChargeBee::Invoice.charge({
     :subscription_id => "future_billing", 
     :amount => 1000, 
     :description => "Support charge"
   })
   print result
  rescue ChargeBee::APIError => e
   print_errors(e)
  end
end

def create_invoice_for_addon
  begin
    result = ChargeBee::Invoice.charge_addon({
         :subscription_id => "future_billing", 
         :addon_id => "asdsday_pass", 
         :addon_quantity => 2
    })
    puts result
  rescue ChargeBee::APIError => e
   print_errors(e)
  end
end

#create_sub
#update_sub
#hosted_page
#checkout_existing
#create_invoice_for_charge
create_invoice_for_addon

