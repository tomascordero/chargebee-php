import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="localcb.in:8080"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__dJIiuf4qr6gcuTiPLiBSY1Zm40o4vcdFAT","mannar-test")

def retrievSub():
  result = chargebee.Subscription.retrieve("active_direct")
#  print result.customer
  print result.customer.cf_date_of_birth
  print result.customer.cf_social_security_no
  print result.customer.asdsad

retrievSub()
v = "cf_date_of_birth"
print v[0:3]

