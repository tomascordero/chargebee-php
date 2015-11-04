import unittest
import os,sys

sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))

import chargebee
from chargebee.environment import Environment
from chargebee.main import ChargeBee
from chargebee.util import serialize

Environment.chargebee_domain = "localcb.in:8080"
ChargeBee.verify_ca_certs = False
Environment.protocol = "http"
chargebee.configure("test___dev__cuwdrqzezGcuMOcL44LvcdWiyccdOkizHuAX", "mannar-test")

#id = "__dev__3Nl8GwLPT2putC4"
#id = " "
id = None
#if id == None or not id.strip() :
#   raise Exception("empty")
print id

#result = chargebee.Subscription.retrieve(id)
#print result


result = chargebee.Subscription.subscriptions_for_customer(id);
for entry in result:
    subscription = entry.subscription
    print subscription
