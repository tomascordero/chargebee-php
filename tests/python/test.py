import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="localcb.in:8080"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__5k3ITyBHNxKqG2KoFuOo1Agb7UZhrZMq","mannar-test")
#result = chargebee.Customer.update_billing_info("cbdemo_263B4XOLF2wUq9", {
#    "billing_address" : {
#        "address_line1" : "340 S LEMON AVE #1537", 
#        "city" : "Walnut", 
#        "state" : "CA", 
#        "zip" : "91789", 
#        "country" : "US"
#    }
#})

#customer = result.customer
#card = result.card

## Test yours
#print customer.billing_address

#result = chargebee.Customer.list({"limit":5})
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
   sub_id = u"a\xac\u1234\u20ac"
   params = {"plan_id" : "basic", "id" : sub_id}
   print(params)
   result = chargebee.Subscription.create(params)
   print(result.subscription)
    
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

# list_coupon()
#create_coupon()
# sub_renewal_estimate()
#sub_add_addon_term_end()
#sub_add_charge_term_end()
test_plan()
#test_addons()
#list_comments()
#create_comment()
#delete_comment()
#retrieve_comment()
#list_sub_for_cust()
#create_sub_for_customer()
#create_subscription()
