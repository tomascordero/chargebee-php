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



