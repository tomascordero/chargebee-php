import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="localcb.in:8080"
Environment.protocol = "http"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__nT9OODXcYvFqWpVkcd5n01J3RaE52fkhf","mannar-test")


result = chargebee.Subscription.create({ "plan_id" : "basic",
                                         "affiliate_token" : "12345",
                                         "created_from_ip" : "192.168.1.1" })

print result.subscription
print result.customer

