require '../../ruby/lib/chargebee.rb';
$CHARGEBEE_DOMAIN = "localcb.in:8080"
#$CHARGEBEE_DOMAIN = "stagingcb.com"
ChargeBee.verify_ca_certs=(false)
#$ENV_PROTOCOL = "http"
#ChargeBee.verify_ca_certs=(true)

#Code from apidocs
ChargeBee.configure(:site => "mannar-test",
  :api_key => "test___dev__zUrPD7kAFPBWcdcGn84UTo5PY570A0vsl")


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


test_void_invoice()
#test_create_sub_customer()
#test_invoice_note()
#test_update_sub()
#test_create_invoice()
#test_create_invoice_for_charge()
#test_create_invoice_for_addon()
#test_amount_due()
#test_redirect_cancel_url()
