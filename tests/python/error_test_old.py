import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../../chargebee-python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
import json
from chargebee.main import Environment
from chargebee import APIError
Environment.chargebee_domain="localcb.in:8080"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__NqcddV3mrcu9pWqcyacuq0twyYyXXPrVlcuj","mannar-test")

def print_error(e):
    print "OLD ERRORS"
    print e.error_code
    print e.http_code
    print e.message
    print e.param
    print "NEW ERRORS"
    print e.json_obj["type"]
    print e.json_obj["api_error_code"]
    print e.json_obj.get("param") 
    print e.json_obj["message"]
    #print json.dumps(e.json_obj)

def create_sub():
  try :
    result = chargebee.Subscription.create({
      "plan_id" : "basic", 
      "coupon" : "plan_only_coupon",
      "customer" : {
        # "email" : "johnasdsaduser.com", 
         "first_name" : "John", 
         "last_name" : "Doe", 
         "phone" : "+1-949-999-9999"
      }, 
      "billing_address" : {
         "first_name" : "John", 
         "last_name" : "Doe", 
         "line1" : "PO Box 9999", 
         "city" : "Walnut", 
         "state" : "CA", 
         "zip" : "91789", 
         "country" : "US"
      }, 
      "addons" : [{
        "id" : "ssl"
     }]
    })
    print result
  except APIError as e:
    print_error(e)

def update_subscription():
  try:
    result = chargebee.Subscription.update("__dev__XpbG8HXOpwIWifu", {
        "plan_id" : "basic", 
        "billing_address" : {
            "first_name" : "John", 
            "last_name" : "Doe", 
            "line1" : "PO Box 9999", 
            "city" : "Walnut", 
            "state" : "CA", 
            "zip" : "600059",
            "country" : "US"
       }
    })
  except APIError as e:
    print_error(e)

def hosted_pages():
  try:
    result = chargebee.HostedPage.checkout_new({
       "subscription" : {
           "plan_id" : "basic",
           "coupon" : "max_redem"
        }, 
        "customer" : {
           "email" : "john@user.com", 
           "first_name" : "John", 
           "last_name" : "Doe", 
           "phone" : "+1-949-999-9999"
        }, 
        "addons" : [{
           "id" : "ssl"
        }]
    })
    print result
  except APIError as e:
    print_error(e)

def create_invoice_for_charge():
  try:
     result = chargebee.Invoice.charge({
        "customer_id" : "asactive_direct", 
        "amount" : "1000", 
        "description" : "Support charge"
     })
     print result
  except APIError as e:
     print_error(e)

def create_invoice_for_addon():
  try:
    result = chargebee.Invoice.charge_addon({
          "subscription_id" : "active_direct",
          "addon_id" : "day_pass",
          "addon_quantity" : "qqwe12"
    })
    print result
  except APIError as e:
    print_error(e)

def list_events():
  try:
     result = chargebee.Event.list({
           "start_time" : 1391299200,
           "end_time" : 1356998400 ,
      })
  except APIError as e:
     print_error(e)


#create_sub()
#update_subscription()
#hosted_pages()
#create_invoice_for_charge()
#create_invoice_for_addon()
list_events()
