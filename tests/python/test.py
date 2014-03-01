import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="localcb.in:8080"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__a1FbWdZkU6USWLb7NnIETx4CMVsPXrX8","mannar-test")
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
    

#list_comments()
#create_comment()
#delete_comment()
#retrieve_comment()
#list_sub_for_cust()
#create_sub_for_customer()
create_subscription()
