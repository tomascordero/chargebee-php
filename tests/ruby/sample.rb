# encoding: utf-8

# Require the chargebee-ruby library directory that is relative
# to your chargebee-app directory.
require '../../ruby/lib/chargebee'
require 'json'

#Use the below settings code to connect the library with the
#local server
$ENV_PROTOCOL = "https"
$CHARGEBEE_DOMAIN = "devcb.in"
ChargeBee.configure({
    :site=> 'raghu-dev-test', #'rrcb-test',
    :api_key => "test_fEAbxv6jhIwEgh8cdwB5cuIGvtGXr2Ibj4"
})
ChargeBee.verify_ca_certs=(true)


#Use the below settings to connect to the production server.
# ChargeBee.configure({
#   :site=> 'mannar-test', #'rrcb-test',
#   :api_key => 'asmbHDtNLNS17eXQJNic6AJquLOgoZDm'#'jaGdadHeCQxfmFQG2sEgSrzHdyt23cwcd'
# })

# Below are the methods to test the specific functionality of the api methods.
def list_subscriptions
  list = ChargeBee::Subscription.list(:limit => 2)
  list.each do |entry|
    subscription = entry.subscription
    customer = entry.customer
    card = entry.card
  end
  puts "#{list.next_offset}"
  list = ChargeBee::Subscription.list(:limit => 2, :offset => list.next_offset.to_s)
  puts "#{list.next_offset}"
end

def update_subscription
  result = ChargeBee::Subscription.update("active_direct", {
    :plan_id => "basic",
    :prorate => "true"
  })
end

def reactivate_subscription
  result = ChargeBee::Subscription.reactivate("canceled_nocard", {
    :trial_period_days => "10",
  })
end

def retrieve_subscription
  result = ChargeBee::Subscription.retrieve('__dev__KyVrKRPHl5UT33q')
  puts result.subscription
end

def retrieve_custom_field
  result = ChargeBee::Subscription.retrieve('active_direct')
  puts result.customer.cf_gender
  puts result.customer.cf_social_security_no
end

def retrive_scheduled_changes
  result = ChargeBee::Subscription.retrieve_with_scheduled_changes('active_direct')
  puts result
end

def delete_scheduled_changes
  result = ChargeBee::Subscription.remove_scheduled_changes('active_direct')
  puts result
end

def charge_addon
  result = ChargeBee::Invoice.charge_addon({
    :subscription_id => "active_direct",
    :addon_id => "sms_credits",
    :quantity => "10"
  })
  puts result.subscription
end

def retrieve_invoice
  result = ChargeBee::Invoice.retrieve("DemoInv_102")
  invoice = result.invoice
  puts invoice
end  

# puts result.customer.cf_market_name
# puts (result.subscription.total_dues()  > 0) ? 'true' : 'false'

def update_address(handle)
  result = ChargeBee::Address.update({
    :subscription_id => handle,
    :label => "shipping_address",
    :addr => "340 S LEMON AVE #1537",
    :city => "Walnut",
    :state => "CA",
    :zip => "91789",
    :country => "United States"
  })
  address = result.address
  subscription = result.subscription
  puts "#{subscription}"
  customer = result.customer
  puts "#{customer}"
end

def retrieve_address(handle, label)
  result = ChargeBee::Address.retrieve({
    :subscription_id => handle,
    :label => label
  })
  address = result.address
  puts "#{address}"
end

def create_subscription
  result = ChargeBee::Subscription.create({
    :plan_id => "professional",
    :affiliate_token => "123",
    :created_from_ip => "66.123.87.9",
    :customer => {
      :email => "john@user.com",
      :first_name => "John",
      :last_name => "Wayne",
    },
    :card => {
      :first_name => "John",
      :last_name => "Wayne",
      :number => "4111111111111111",
      :expiry_month => 4,
      :expiry_year => 2015,
      :cvv => "411",
      :billing_country => "IN"
    }
  })
  puts result.subscription
  puts result
#  puts result.subscription.current_term_start==nil ? 'true' : 'false'
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
    ]
  })
  puts "#{result.estimate}"
end

def delete_card
  result = ChargeBee::Card.delete_card_for_customer("__dev__8avOqOSpwfMSU")
  puts result.customer
end

def invoice_transactions
  list = ChargeBee::Transaction.transactions_for_invoice("__demo_inv__3", {
    :limit => 5
  })
  list.each do |entry|
    puts "#{entry.transaction}"
  end
end

# Below are the methods to test the specific functionality of the api methods.

def list_sub_for_cust
  list = ChargeBee::Subscription.subscriptions_for_customer("active_direct", {
    :limit => 5
  })
  puts list.to_s
 list.each do |entry|
#    puts entry.subscription
#    puts entry.customer
#    puts entry.card
   puts entry.to_s
  end
end

def create_sub_for_cust(cust_id)
  result = ChargeBee::Subscription.create_for_customer(cust_id, {
    :plan_id => "professional",
    :coupon =>"plan_only_coupon",
    :addons => [{
      :id=>"sms_credits",
      :quantity => 2
      }]
      },nil,{
        "chargebee-event-email" => "all-disabled"
      }
    )
  puts result.to_s
end

def update_payment_method
  result = ChargeBee::Customer.update_payment_method("HpvtAaeP9MUKXUdA", {
    :payment_method => {
      :type => "paypal_express_checkout", 
      :reference_id => "B-58N742152Y721200U"
    }
  })
  puts result
end

def list_comments
  params = Array.new
  list = ChargeBee::Comment.list(:limit => 2)
  list.each do |entry|
    puts entry.comment
  end
end

def delete_comment
result = ChargeBee::Comment.delete("cmt___dev__8avUDOSFTj6a4")
puts result.comment
end

def retrieve_comment
result = ChargeBee::Comment.retrieve("cmt___dev__8avRoOSpmuZdY")
puts result.comment
end

def create_comment
result = ChargeBee::Comment.create({
  :entity_type => "subscription",
  :entity_id => "trial_ends_in_two_days",
  :notes => "This is my test comment from ruby"
})
puts result.comment
end

def create_plan
result = ChargeBee::Plan.create({
  :id => "rub_plan_1",
  :name => "Rub Plan 1",
  :invoice_name => "invoice name 1",
  :description => "ruby plan for testing purpose",
  :trial_period => 5,
  :trial_period_unit => "day",
  :price => 2000,
  :setup_cost => 300,
  :charge_model => "flat_fee",
  :billing_cycles => 10,
  :downgrade_penalty => 5.9,
  :redirect_url => "http://apidocs.localcb.in:8080/docs/api/comments?lang=ruby#create_a_comment",
  :enabled_in_hosted_pages => "true"
})
puts result.plan
end

def retrieve_plan
 result = ChargeBee::Plan.retrieve("rub_plan_1")
 print result
 print result.plan.charge_model
 print result.plan.period
 print result.plan.period_unit
 print result.plan.enabled_in_hosted_pages
end

def update_plan
result = ChargeBee::Plan.update("rub_plan", :enabled_in_hosted_pages=>"false")
puts result.plan
end

def create_addon
result = ChargeBee::Addon.create({
  :id => "rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2",
  :name => "Rub Addon2 Rub Addon2",
  :invoice_name => "invoice name",
  :description => "rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_rub_addon2_",
  :charge_type => "recurring",
  :period => 5,
  :period_unit => "week",
  :price => 2000,
  :type => "quantity"

})
puts result.addon
end

def refund_invoice
result = ChargeBee::Invoice.refund("__demo_inv__1",{
  #:refund_amount => 200,
  :memo => "just a test refund"

})
puts result
end

def refund_transaction
result = ChargeBee::Transaction.refund("txn___dev__8avZiOUUwxFC5",{
  #:refund_amount => 1100,
  :memo => "refund transaction test"

})
puts result
end

def retrieve_coupon
  result = ChargeBee::Coupon.retrieve("test_coupon")
  coupon = result.coupon
  coupon.plan_ids.each do | plan_id |
    puts plan_id
  end
end

def list_coupon
  list = ChargeBee::Coupon.list(:limit => 5)
  list.each do |entry|
     coupon = entry.coupon
     print coupon.redemptions
     print coupon
  end
end


def deserialize_event
  evt = ChargeBee::Event.deserialize('{"id":"ev_HstHxZvOMPJm2eK2k","occurred_at":1383734697,"source":"api","object":"event","content":{"subscription":{"id":"41609","plan_id":"blossom_monthly","plan_quantity":8,"status":"active","trial_start":1372946940,"trial_end":1372947702,"current_term_start":1383574902,"current_term_end":1386166902,"created_at":1369412964,"started_at":1369412964,"activated_at":1381392277,"cancel_reason":"not_paid","due_invoices_count":0,"object":"subscription"},"customer":{"id":"41609","first_name":"Staffan","last_name":"Einarsson","email":"staffan.einarsson@muchdifferent.com","company":"Pikkotekk AB","auto_collection":"on","created_at":1369412964,"object":"customer","card_status":"valid","billing_address":{"line1":"PikkoTekk AB","line2":"Övre Slottsgatan 22C","city":"Uppsala","state":"Uppsala Län","country":"Sweden","zip":"75312","object":"billing_address"}},"card":{"customer_id":"41609","status":"valid","gateway":"braintree","first_name":"Staffan","last_name":"Einarsson","iin":"407513","last4":"1173","card_type":"visa","expiry_month":8,"expiry_year":2015,"billing_addr1":"PikkoTekk AB","billing_addr2":"Övre Slottsgatan 22C","billing_city":"Uppsala","billing_state":"Uppsala Län","billing_country":"Sweden","billing_zip":"75312","object":"card","masked_number":"************1173"}},"event_type":"subscription_changed","webhook_status":"scheduled"}')
end

def create_portal_session
  result = ChargeBee::PortalSession.create({
    :customer => {
      :id => "2slhRVVBP4RyYhYTHp"
    },
    :redirect_url => "https://www.chargebee.com/thanks.html", 
  })
  puts result.portal_session
end

def retrieve_portal_session(session_id)
  result = ChargeBee::PortalSession.retrieve(session_id)
  puts result.portal_session
end

def logout_portal_session(session_id)
  result = ChargeBee::PortalSession.logout(session_id)
  puts result.portal_session
end

def activate_portal_session()
  result = ChargeBee::PortalSession.activate("portal_2uENY2zdP5Tllqa8f3", {
    :token => "5SYIXQJdVLWQCObgtIXR4vlMUnXRoyEq"
  })
  puts result.portal_session
end

def list_txn_for_customer
  list = ChargeBee::Transaction.transactions_for_customer("1mqYqnaPDgsBL1sy", {
    :limit => 10
  })
  list.each do |entry|
    puts "#{entry.transaction}"
  end
end

def create_invoice
result = ChargeBee::Invoice.charge({
  :customer_id => "future_billing",
  #:subscription_id => "future_billing",
  :amount => 1200,
  :description => "testasdfasf" ,
  :coupon => "acme26259inc"
})
puts result.invoice
end

def create_invoice_addon
result = ChargeBee::Invoice.charge_addon({
  #:customer_id => "future_billing",
  :subscription_id => "future_billing",
  :addon_id => "day_pass",
  :addon_quantity => 2,
  :coupon => "acme26259inc"
})
puts result.invoice
end

def collect_payment
  result = ChargeBee::Invoice.collect_payment("7041")
  print result
end

def add_charge_at_term_end
  result = ChargeBee::Subscription.add_charge_at_term_end("__dev__XpbGBGYOlOtWQPN");
  print result.estimate.amount
  print result.estimate
end

def add_non_rec_addon_at_term_end
  result = ChargeBee::Subscription.charge_addon_at_term_end("__dev__XpbGBGYOlOtWQPN", {
    :addon_id => "non_recurring_addon_quantity", 
    :addon_quantity => 2
  })
  print result.estimate.amount
  print result.estimate
end

def sub_renewal_estimate
  result = ChargeBee::Estimate.renewal_estimate("__dev__XpbGBGYOlOtWQPN");
  print result.estimate.amount
  print result.estimate
end

def checkout_new
   result = ChargeBee::HostedPage.checkout_new({ :subscription => { :id => "4321", :plan_id => "professional" },
    #                                             :customer => { :id => "123" }, 
						 :addons => [{:id => "ssl"}] })
   print result.hosted_page
end

def create_order(inv_id)
  result = ChargeBee::Order.create({:invoice_id => inv_id, :status => "new", :fulfillment_status => "Shipped"})
  print result.order
end

def retrieve_order(order_id)
  result = ChargeBee::Order.retrieve(order_id)
  print result.order
end

def update_order(order_id)
  result = ChargeBee::Order.update(order_id, {:status => "processing"})
  print result.order
end

def list_orders()
  result = ChargeBee::Order.list()
  print result.inspect
end

def list_orders_for_invoice(inv_id)
  result = ChargeBee::Order.orders_for_invoice(inv_id)
  print result.inspect
end

def rertrive_transaction
  result = ChargeBee::Transaction.retrieve("txn_2uENY37cPMGqWIW22dT")
  transaction = result.transaction
  puts transaction
end  

def retrieve_event
  result = ChargeBee::Event.retrieve("ev_1sGhD9KPMGxzKF1cq")
  event = result.event
  puts event
end

def create_invoice()
  result = ChargeBee::Invoice.create({
    :customer_id => "2slhRVVBP4RyYhYTHp", 
    :coupon => "one_time",
    :addons => [{
      :id => "non_rec_on_off"
    },
    {
      :id => "one-off_consulting_support", 
      :quantity => 2
    }], 
    :charges => [{
      :amount => 2030, 
      :description => "Support charge"
    }],
    :shipping_address => {
      :first_name => "fName",
      :last_name => "lName",
      :email => "email@test.com",
      :company => "company",
      :phone => "phone",
      :line1 => "line1",
      :line2 => "line2",
      :line3 => "line3",
      :city => "city",
      :state_code => "NY",
      :zip => "56768",
      :country => "US"
    }
  })
  puts result.invoice
end

# Comment the methods you don't want to run.
begin
 # update_payment_method
  # collect_payment
# checkout_new
# create_subscription
# update_subscription
# delete_card
# invoice_transactions
# update_address("1qBnWmGOIiLbkP1j")
# retrieve_address("1qBnWmGOIiLbkP1j", "shipping_address")
# deserialize_event()
# estimate_create_subscription
# list_subscriptions
# retrieve_subscription
# retrive_scheduled_changes
# delete_scheduled_changes
# charge_addon
# list_comments
# create_comment
# create_plan
# retrieve_plan
# update_plan
# create_addon
# retrieve_custom_field
# retrieve_comment
# list_sub_for_cust
# refund_invoice()
# refund_transaction()
# retrieve_coupon()
# list_coupon()
#list_txn_for_customer()
#create_invoice()
#create_invoice_addon()
# create_portal_session()
# retrieve_portal_session('portal_2uENY2zdP5Tllqa8f3')
# activate_portal_session()
# logout_portal_session('__dev__5unJ34tVUIKPddcdw3nCjyFgwmlU8E5Hf')
# add_charge_at_term_end()
# add_non_rec_addon_at_term_end()
# sub_renewal_estimate()
# puts ChargeBee::Util.serialize({
#   :id => "rub_addon2",
#   :name => "Rub Addon2",
#   :invoice_name => "invoice name",
#   :charge_type => "recurring",
#   :addon_ids=>["one","two"],
#   :period => 5,
#   :period_unit => "week",
#   :price => 2000,
#   :type => "quantity",
#   :prorate => true
# });
# create_order("__demo_inv__21")
# retrieve_order("__dev__XpbGU6hOxIel9p6")
# update_order("__dev__XpbGU6hOxIel9p6")
# list_orders()
# list_orders_for_invoice("__demo_inv__21")
# create_invoice()
# create_sub_for_cust("cust_handle")
#retrieve_invoice();
#rertrive_transaction()
#retrieve_event()
rescue ChargeBee::APIError => e
  puts e
end
