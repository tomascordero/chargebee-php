"""
Contains sample codes & functions to work with our php library. 
"""
import os,sys

"""
Require the chargebee-php library from the code base that is relative to the chargebee-app directory 
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
chargebee.configure("test___dev__gowhPcVPJyj1HrDjaLM8EEbD1XsQQK0B", "mannar-test")

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
                "plan_id" : "basic"
            }, 
            "embed":"false"
        })
    hosted_page = result.hosted_page
    print(hosted_page)

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
    result = chargebee.Subscription.retrieve("__dev__8avRoOSpoUX6b")
    print(result.subscription)
    if(result.subscription.coupons != None):
        for c in result.subscription.coupons:
            print(c)
    print (result.subscription.trial_start, result.subscription.trial_end, result.subscription.created_at)
    if(result.subscription.trial_start == None):
        print("never been in trial")


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
		"period":5,
		"price":4000,
		"setup_cost":200,
		"billing_cycles":1,
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

def refundTransaction():
    result = chargebee.Transaction.refund("txn___dev__8avZiOUV24vV1c",{
		"refund_amount":900,
                "memo":"Just to refund"
        })
    print(result)

def retrieveCoupon():
  result = chargebee.Coupon.retrieve("test")
  coupon = result.coupon
  print(coupon.plan_ids);


"""
Comment out the methods you don't want to run.
"""            
#retrieve_subscription()
#list_subscriptions()
#create_estimate()
# list_events()
# create_estimate()
#new_checkout()
#retrive_hostedpage()
#test_serialize()
#create_plan();
#create_addon();
#refundInvoice();
#refundTransaction();
retrieveCoupon();


