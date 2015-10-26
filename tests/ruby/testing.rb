require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test",
  :api_key => "test___dev__cu4CboYwBfeX4gKO8QMwGWZIQvcdFwNaZf")


def test_invoice_note
   result = ChargeBee::Subscription.create({
             :plan_id => "gold", 
             :customer => { :email => "john@user.com", 
                             :first_name => "John", 
                              :last_name => "Doe", 
                              :phone => "+1-949-999-9999",
                              :auto_collection => "off"
                            },
            :po_number => "PO number",
            :invoice_notes => "Invoice notes for sub creation",
            :coupon => "NOTESCOUPON"
            })
    puts result
end

def test_create_sub_customer
  result = ChargeBee::Subscription.create_for_customer("__dev__KyVqkOP9GuxDMF", {
    :plan_id => "gold", 
    :addons => [{
      :id => "on-off"
    }],
    :coupon => "NOTESCOUPON"
  })
  puts result
end


def test_update_sub
  begin
  result = ChargeBee::Subscription.update("__dev__KyVqkOP9H79kyh", {
  #result = ChargeBee::Subscription.update("\n\n", {
    :plan_id => "no-trial",
    :billing_cycles => 3,
    :invoice_notes => "Update sub notes passed",
    :po_number => "update_po_number"
  })
  puts result
rescue ChargeBee::InvalidRequestError=> ex
  puts ex.api_error_code
end
  
end


def test_create_invoice
  result = ChargeBee::Invoice.create({
    :customer_id => "__dev__KyVqkOP9H79kyh", 
    :charges => [{
      :amount => 1000, 
      :description => "Support charge"
    }],
    :po_number => "po number"
  })
  puts result
end

def test_create_invoice_for_charge
  result = ChargeBee::Invoice.charge({
    :subscription_id => "__dev__KyVqkOP9H79kyh", 
    :amount => 200, 
    :description => "Support charge",
    :po_number => "asdsadsad"
  })
end

def test_create_invoice_for_addon
  result = ChargeBee::Invoice.charge_addon({
    :subscription_id => "__dev__KyVqkOP9H79kyh", 
    :addon_id => "day-pass", 
    :addon_quantity => 2,
    :po_number => " asdads    "
  })
  puts result
end

def test_amount_due
  result = ChargeBee::Invoice.retrieve("__demo_inv__40")
  puts result
  puts result.invoice.amount_due
end

def test_redirect_cancel_url
  result = ChargeBee::HostedPage.checkout_new({
    :subscription => {
      :plan_id => "cbee_multiple_site_plan"
    },
    :redirect_url => "http://asdsad.com",
    :cancel_url => "http://cancelur.com"
  })
  puts result.hosted_page
end

def test_void_invoice
 result = ChargeBee::Invoice.void_invoice("__demo_inv__36")
 puts result.invoice
 puts result.invoice.status
end


def estimate_create_subscription
  result = ChargeBee::Estimate.create_subscription({
    :subscription => {
      :plan_id => "basic",
    },
    :customer => {
      :email => "john@user.com",
      :first_name => "John",
      :last_name => "Wayne"
    },
    :addons => [
    ],
    :billing_address => {
      :country => "US",
      :state_code => "AB",
      :zip => "12345"
    },
    :shipping_address => {
      :country => "US", 
      :state_code => "CA",
      :zip => "12345"
    }
  })
  print result.estimate
end



def create_customer(handle)
  result = ChargeBee::Customer.create({
    :first_name => "John", 
    :last_name => "Doe", 
    :email => "john@test.com", 
    :id => handle,
    :allow_direct_debit => "true",
    :billing_address => {
      :first_name => "John", 
      :last_name => "Doe", 
      :line1 => "PO Box 9999", 
      :city => "Walnut", 
      :state => "California", 
      :zip => "91789", 
      :country => "US"
    },
  })
  print result.customer
end

def  update_customer(handle)
  create_customer(handle)
  result = ChargeBee::Customer.update(handle, {
    :first_name => "Denise", 
    :last_name => "Barone",
    :allow_direct_debit => "true"
  })
  print result.customer  
end

def get_customer(handle)
  create_customer(handle)
  result = ChargeBee::Customer.retrieve(handle)
  customer = result.customer
  print result.customer 
end

def create_no_trial_sub(handle)
  result = ChargeBee::Subscription.create({
    :id => handle,
  :plan_id => "no-trial", 
  :customer => {
    :email => "john@user.com", 
    :first_name => "John", 
    :last_name => "Doe", 
    :phone => "+1-949-999-9999",
    :auto_collection => "off"
  }, 
  :billing_address => {
    :first_name => "John", 
    :last_name => "Doe", 
    :line1 => "PO Box 9999", 
    :city => "Walnut", 
    :state => "California", 
    :zip => "91789", 
    :country => "US"
  },
    :shipping_address => {
      :country => "US", 
      :state_code => "CA",
      :zip => "12345"
    }
})
end

def create_invoice(handle)
  create_no_trial_sub(handle)
  list = ChargeBee::Invoice.invoices_for_subscription(handle, {
      :limit => 1
      })  
  list.each do |entry|
    invoice = entry.invoice
    print invoice
  end
end

# test_void_invoice()
#test_create_sub_customer()
#test_invoice_note()
#test_update_sub()
# test_create_invoice_for_charge()
#test_create_invoice_for_addon()
#test_amount_due()
#test_redirect_cancel_url()
# puts "Estimate"
# estimate_create_subscription
# puts "create_customer"
# create_customer("test1")
# puts "update_customer"
# update_customer("test2")
# puts "get_customer"
# get_customer("test3")
puts "invoice"
create_invoice("asq1")