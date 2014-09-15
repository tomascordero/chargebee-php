import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
from chargebee import APIError
Environment.chargebee_domain="localcb.in:8080"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__NqcddV3mrcu9pWqcyacuq0twyYyXXPrVlcuj","mannar-test")

def create_sub():
  try :
    result = chargebee.Subscription.create({
      "plan_id" : "basic", 
      "coupon" : "max_redem",
      "customer" : {
         "email" : "johnasdsaduser.com", 
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
    print e

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
    print e

def create_invoice_for_charge():
  try:
     result = chargebee.Invoice.charge({
        "customer_id" : "asactive_direct", 
        "amount" : "1000", 
        "description" : "Support charge"
     })
     print result
  except APIError as e:
     print e

def create_invoice_for_addon():
  try:
    result = chargebee.Invoice.charge_addon({
          "subscription_id" : "active_direct",
          "addon_id" : "day_pass",
          "addon_quantity" : "12"
    })
    print result
  except APIError as e:
    print e


#create_sub()
#hosted_pages();
#create_invoice_for_charge()
create_invoice_for_addon()
