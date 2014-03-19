# encoding: utf-8

# Require the chargebee-ruby library directory that is relative
# to your chargebee-app directory.
require '../../ruby/lib/chargebee'
require 'json'

#Use the below settings code to connect the library with the
#local server
$CHARGEBEE_DOMAIN = "localcb.in:8080"
ChargeBee.configure({
    :site=> 'mannar-test', #'rrcb-test',
    :api_key => 'test___dev__k80L73PSKiQhnFJK32qCYiVZuSOHoxcdcd'
})
ChargeBee.verify_ca_certs=(false)

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
  result = ChargeBee::Subscription.retrieve('__dev__8avRoOSpXRWML')
  puts result.subscription
end

def charge_addon
  result = ChargeBee::Invoice.charge_addon({
    :subscription_id => "active_direct",
    :addon_id => "sms_credits",
    :quantity => "10"
  })
  puts result.subscription
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
    :plan_id => "no_trial",
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
      :expiry_year => 2014,
      :cvv => "411",
      :billing_country => "IN"
    }
  })
  puts result.subscription
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

def create_sub_for_customer
  result = ChargeBee::Subscription.create_for_customer("active_direct",
							{ :plan_id => "professional",
							  :coupon =>"plan_only_coupon",
							  :addons => [{ :id=>"sms_credits" , :quantity => 2 }] } )
  puts result.to_s
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
  :id => "rub_plan",
  :name => "Rub Plan",
  :invoice_name => "invoice name",
  :trial_period => 5,
  :trial_period_unit => "day",
  :price => 2000,
  :setup_cost => 300,
  :free_quantity => 2,
  :billing_cycles => 10,
  :downgrade_penalty => 5.9,
  :redirect_url => "http://apidocs.localcb.in:8080/docs/api/comments?lang=ruby#create_a_comment"
})
puts result.plan
end

def create_addon
result = ChargeBee::Addon.create({
  :id => "rub_addon2",
  :name => "Rub Addon2",
  :invoice_name => "invoice name",
  :charge_type => "recurring",
  :period => 5,
  :period_unit => "week",
  :price => 2000,
  :type => "quantity"

})
puts result.addon
end

def refundInvoice
result = ChargeBee::Invoice.refund("__demo_inv__1",{
  #:refund_amount => 200,
  :memo => "just a test refund"

})
puts result
end

def refundTransaction
result = ChargeBee::Transaction.refund("txn___dev__8avZiOUUwxFC5",{
  #:refund_amount => 1100,
  :memo => "refund transaction test"

})
puts result
end

def retrieveCoupon
  result = ChargeBee::Coupon.retrieve("test_coupon")
  coupon = result.coupon
  coupon.plan_ids.each do | plan_id |
    puts plan_id
  end
end


def deserialize_event
  evt = ChargeBee::Event.deserialize('{"id":"ev_HstHxZvOMPJm2eK2k","occurred_at":1383734697,"source":"api","object":"event","content":{"subscription":{"id":"41609","plan_id":"blossom_monthly","plan_quantity":8,"status":"active","trial_start":1372946940,"trial_end":1372947702,"current_term_start":1383574902,"current_term_end":1386166902,"created_at":1369412964,"started_at":1369412964,"activated_at":1381392277,"cancel_reason":"not_paid","due_invoices_count":0,"object":"subscription"},"customer":{"id":"41609","first_name":"Staffan","last_name":"Einarsson","email":"staffan.einarsson@muchdifferent.com","company":"Pikkotekk AB","auto_collection":"on","created_at":1369412964,"object":"customer","card_status":"valid","billing_address":{"line1":"PikkoTekk AB","line2":"Övre Slottsgatan 22C","city":"Uppsala","state":"Uppsala Län","country":"Sweden","zip":"75312","object":"billing_address"}},"card":{"customer_id":"41609","status":"valid","gateway":"braintree","first_name":"Staffan","last_name":"Einarsson","iin":"407513","last4":"1173","card_type":"visa","expiry_month":8,"expiry_year":2015,"billing_addr1":"PikkoTekk AB","billing_addr2":"Övre Slottsgatan 22C","billing_city":"Uppsala","billing_state":"Uppsala Län","billing_country":"Sweden","billing_zip":"75312","object":"card","masked_number":"************1173"}},"event_type":"subscription_changed","webhook_status":"scheduled"}')
end

# Comment the methods you don't want to run.

#create_subscription
# update_subscription
#delete_card
#invoice_transactions
# update_address("1qBnWmGOIiLbkP1j")
# retrieve_address("1qBnWmGOIiLbkP1j", "shipping_address")
#deserialize_event()
# estimate_create_subscription
#list_subscriptions
#retrieve_subscription
# charge_addon
#list_comments
#create_comment
#create_plan
#create_addon
#retrieve_comment
#list_sub_for_cust
#create_sub_for_customer
#refundInvoice()
#refundTransaction()

# retrieveCoupon()

puts ChargeBee::Util.serialize({
  :id => "rub_addon2",
  :name => "Rub Addon2",
  :invoice_name => "invoice name",
  :charge_type => "recurring",
  :addon_ids=>["one","two"],
  :period => 5,
  :period_unit => "week",
  :price => 2000,
  :type => "quantity",
  :prorate => true
});

