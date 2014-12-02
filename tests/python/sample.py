"""
Contains sample codes & functions to work with our php library.
"""
import os,sys

"""
Require the chargebee-python library from the code base that is relative to the chargebee-app directory
"""
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))

"""
Import the necessary chargebee classes.
"""
import chargebee
from chargebee.environment import Environment
from chargebee.main import ChargeBee
from chargebee.util import serialize

"""
Use the below settings to configure the api endpoint with specific domain.
"""
Environment.chargebee_domain = "localcb.in:8080"
ChargeBee.verify_ca_certs = False
Environment.protocol = "http"
chargebee.configure("test___dev__0hcdH60Wi8x2CLOzfsC7AVsDYlfYnbwy7", "mannar-test")

"""
Use the below code to connect to the production server.
"""
# chargebee.configure("YlRMjamvRnwhK8sDYN8miacuJSpSH3EfK", "rrcb-test")

"""
Following are methods to test with sample code for specific functionality. You define the methods here
and call the required method at the end to test.
"""
def new_checkout():
    result = chargebee.HostedPage.checkout_new({
            "subscription" : {
              #  "id" : "42310",
                "plan_id" : "no_trial"
            },
            "customer" : {
               "id" : "03241"
            },
            "embed":"false"
        })
    hosted_page = result.hosted_page
    print(hosted_page)

def update_subscription():
    result = chargebee.Subscription.update("active_direct", {
        "plan_id" : "professional",
        "prorate" : False
    })

def retrive_hostedpage():
    result = chargebee.HostedPage.retrieve("__dev__cugdoVdqOQqJm6rEhtcuEjdSOS0wEAoEHS")
    hosted_page = result.hosted_page
    print(hosted_page)


def list_subscriptions():
    list = chargebee.Subscription.list({"limit" : 10})
    while list.next_offset is not None:
        print(list.next_offset)
        for entry in list:
            subscription = entry.subscription
            print (subscription)
            customer = entry.customer
            card = entry.card
        list = chargebee.Subscription.list({"limit" : 10, "offset":list.next_offset})
        print("length is %s", len(list))

def retrieve_subscription():
    result = chargebee.Subscription.retrieve("active_upgraded")
    print(result.subscription)
    if(result.subscription.coupons != None):
        for c in result.subscription.coupons:
            print(c)
    print (result.subscription.trial_start, result.subscription.trial_end, result.subscription.created_at)
    if(result.subscription.trial_start == None):
        print("never been in trial")

def retrieve_custom_field():
    result = chargebee.Subscription.retrieve("active_direct")
    print result.customer.cf_gender
    print result.customer.cf_social_security_no

def retrieve_scheduled_changes():
    result = chargebee.Subscription.retrieve_with_scheduled_changes("active_upgraded")
    print result.subscription
    print result.subscription.current_term_end

def delete_scheduled_changes():
    result = chargebee.Subscription.remove_scheduled_changes("active_upgraded")
    print result.subscription

def create_estimate():
    result = chargebee.Estimate.create_subscription({
            "subscription" : {
                "plan_id" : "basic"
        }})
    print(result.estimate)

def list_events():
    i = 0;
    offset = ""
    while offset != None and i < 3:
        result = chargebee.Event.list({
            "limit" : 10
        })
        i += 1
        for item in result:
        	evt = item.event
        	print(evt.occurred_at, evt.event_type, evt.id, evt.webhook_status)
        offset = result.next_offset

def test_serialize():
    print(2 or '')
    print(serialize({'subscription':{'plan_quantity':0}}))
    print(serialize({'subscription':{'plan_quantity':1}}))

def create_plan():
    result = chargebee.Plan.create({
               	"id" : "nested_plan1",
		        "name":"Nested Plan1",
		        "invoice_name":"nested plan",
                "description":"this is test plan created from py lib",
		        "period":5,
		        "price":4000,
		        "setup_cost":200,
		        "billing_cycles":1,
                "charge_model":"per_unit",
		        "free_quantity":10,
		        "downgrade_penalty":0.5,
		        "trial_period":2,
		        "trial_period_unit":"day"
            })
    print(result.plan)

def create_addon():
    result = chargebee.Addon.create({
                "id" : "test_addon2",
                "name":"test Addon2",
                "invoice_name":"test addon",
		        "charge_type":"non_recurring",
                "description":"test addon 2 test addon 2 test addon 2 test addon 2 test addon 2 test addon 2",
		        #"period":2,
		        "period_unit":"not_applicable",
                "type":"quantity",
		        "unit":"Agent",
                "price":4000
            })
    print(result.addon)

def refundInvoice():
    result = chargebee.Invoice.refund("DemoInv_105",{
		"refund_amount":1200,
                "memo":"Just to refund"
        })
    print(result)


def retrieveCoupon():
    result = chargebee.Coupon.retrieve("test")
    coupon = result.coupon
    print(coupon.plan_ids);

def create_portal_session():
    result = chargebee.PortalSession.create({
        "redirect_url" : "https://yourdomain.com/users/3490343", 
        "customer" : {
            "id" : "future_billing"
        }
    })
    print(result.portal_session)

def retrieve_portal_session(session_id):
    result = chargebee.PortalSession.retrieve(session_id)
    print(result.portal_session)

def logout_portal_session(session_id):
    result = chargebee.PortalSession.logout(session_id)
    print(result.portal_session)


def list_txn_for_customer():
    result = chargebee.Transaction.transactions_for_customer("__dev__3Nl8GtNOhW3bslC");
    for entry in result:
       transaction = entry.transaction
       print(transaction)

def create_invoice_for_charge():
    result = chargebee.Invoice.charge({ "customer_id" : "1",
                                        "amount" : 1000,
                                        "coupon" : "one_time_coupon",
                                        "description" : "support charge" });
    print(result)


def create_invoice_for_addon():
   result = chargebee.Invoice.charge_addon({"subscription_id": "002",
                                            "addon_id" : "addon" })
                                           # "addon_quantity" : 3})
   print result

def list_comments():
 #list = chargebee.Comment.list({"limit":5,"entity_type":"plan" , "entity_id" : "professional"})
 list = chargebee.Comment.list({"limit":5})
 # print list
 for entry in list:
            comment = entry.comment
            print (comment)

def create_comment():
    result = chargebee.Comment.create({
     "entity_type" : "subscription", 
     "entity_id" : "active_upgraded", 
     "notes" : "This is python test asdlhbasdfb; asdfjlbsakfd   as;fhas;fhdaskjhsdafj asfdljhsdalkjfh asflkjlaskjf alkjsfbkjasla alksbfkjbsdf alskjf kajbsfsdaf",
     "added_by" : "unkown"
    })
    print(result)

def delete_comment():
    result = chargebee.Comment.delete("cmt___dev__8avRoOSpbLynT")
    print(result.comment)

def retrieve_comment():
    result = chargebee.Comment.retrieve("cmt___dev__8avRoOSpbLynT")
    print(result.comment)

def list_sub_for_cust():
   list = chargebee.Subscription.subscriptions_for_customer("trial", {
     "limit" : 5
   })
   for entry in list:
     print(entry.subscription)
     print(entry.customer)
     print(entry.card)
     print(entry.invoice)

def create_sub_for_customer():
   result = chargebee.Subscription.create_for_customer("trial", {
    "plan_id" : "basic",
    "coupon" : "plan_only_coupon",
    "addons" : [ { "id" : "sms_credits", "quantity" : "2" } ]
   })
   print(result)

def create_subscription():
   sub_id = "12345"
   first_name = raw_input("first Name").decode("utf-8")
   print type(first_name)
   params = {"plan_id" : "basic", "affiliate_token" : "3241", "created_from_ip" : "34:213:11:1",
             "customer" : {"first_name": first_name, "auto_collection": "off"} }
   print(params)
   result = chargebee.Subscription.create(params)
   print(result.subscription)
   print(result.customer.first_name)
    
def test_addons():
   result = chargebee.Addon.create({
    "id" : "test_addon_2", 
    "name" : "test addon 2", 
    "invoice_name" : "testing addon 1 desc", 
    "charge_type" : "recurring", 
    "price" : 200, 
    "period" : 1,
    "description" : "Description about testing 1 addons will come here", 
    "period_unit" : "month", 
    "type" : "on_off"
   })
   print result.addon

def test_plan():
  result = chargebee.Plan.create({
             "id" : "silver6", 
             "name" : "Silver6", 
             "invoice_name" : "silver6", 
             "price" : 5000,
             "charge_model" : "per_unit",
             "free_quantity" : 3,
             "plan_quantity" : 5,
             "enabled_in_hosted_pages":"true" 
  })
  plan = result.plan
  print plan.charge_model
  print plan.enabled_in_hosted_pages
  print plan

def sub_add_charge_term_end():
  result = chargebee.Subscription.add_charge_at_term_end("__dev__KyVpQIOlJofLpB", {
    "amount" : 2000, 
    "description" : "Support charge"
  })
  print result.estimate

def sub_add_addon_term_end():
 result = chargebee.Subscription.charge_addon_at_term_end("__dev__KyVpQIOlJofLpB", {
    "addon_id" : "non_recurring_addon_quantity",
    "addon_quantity" : 2 
 })
 print result.estimate

def sub_renewal_estimate():
 result = chargebee.Estimate.renewal_estimate("__dev__KyVpQIOlJofLpB")
 print result.estimate.amount
 print result.estimate

def create_coupon():
 result = chargebee.Coupon.create({
    "id" : "sample_offer", 
    "name" : "Sample Offer", 
    "discount_type" : "fixed_amount", 
    "discount_amount" : 500, 
    "apply_on" : "invoice_amount", 
    "duration_type" : "forever"
 })
 print result.coupon

def list_coupon():
 list = chargebee.Coupon.list({"limit" : 5})
 for entry in list:
    coupon = entry.coupon
    print coupon.redemptions
    print coupon
    

def create_order():
    result = chargebee.Order.create({
        "invoice_id" : "__demo_inv__8",
        "status" : "new",
        "fulfillment_status" : "Shipped"
    })
    print result.order

def retrieve_order(order_id):
    result = chargebee.Order.retrieve(order_id)
    print result.order

def update_order(order_id):
    result = chargebee.Order.update(order_id, {"status" : "processing"})
    print result.order
    
def list_orders():
    list_result = chargebee.Order.list({"limit" : 5}) 
    for entry in list_result:
        print entry.order
        
def list_inv_orders():
    list_result = chargebee.Order.orders_for_invoice("__demo_inv__8", {"limit" : 5})
    for entry in list_result:
        print entry.order
        

"""
Comment out the methods you don't want to run.
"""

# create_invoice_for_addon()
#create_invoice_for_charge()
#list_txn_for_customer()
#retrieve_subscription()
#retrieve_custom_field()
# update_subscription()
#list_subscriptions()
#create_estimate()
#list_events()
#create_estimate()
#new_checkout()
#retrive_hostedpage()
#test_serialize()
#create_plan()
#delete_scheduled_changes()
#retrieve_scheduled_changes()
#create_addon()
#refundInvoice()
#retrieveCoupon()
#create_portal_session()
#retrieve_portal_session('__dev__qZIGuC6SuOX1RTA75A1nraSVsXtSURLY')
#logout_portal_session('__dev__qZIGuC6SuOX1RTA75A1nraSVsXtSURLY')

# list_coupon()
#create_coupon()
# sub_renewal_estimate()
#sub_add_addon_term_end()
#sub_add_charge_term_end()
#test_plan()
#test_addons()
#list_comments()
#create_comment()
#delete_comment()
#retrieve_comment()
#list_sub_for_cust()
#create_sub_for_customer()
# create_subscription()
# create_order()
# retrieve_order("__dev__XpbGU7pOxD8GPd1")
# update_order("__dev__XpbGU7pOxD8GPd1")
# list_orders()
list_inv_orders()
# print serialize({
#     "id" : "test_addon2",
#     "name":"test Addon2",
#     "invoice_name":"test addon",
#     "charge_type":"non_recurring",
#     "prorate":True,
#     "period_unit":"not_applicable",
#     "type":"quantity",
#     "unit":"Agent",
#     "price":4000,
#     "addons":["one","two"]
#     });
