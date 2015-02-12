# -*- coding: UTF-8 -*-
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
chargebee.configure("test___dev__NgweVXGDQfsY10iCdmcuXkjwgK16QpUja", "mannar-test")

def create_sub():
    if sys.version_info[0] == 2:
      fn = raw_input().decode(sys.stdin.encoding or locale.getpreferredencoding(True)) 
    else: 
      fn = input()
    #print fn
    #print type(fn)
    print(fn.encode("utf-16"))
    print(type(fn))
    #fn = fn.encode("UTF-8")
    print(fn)
    d = {  "plan_id" : "flat-fee-trial",
           "id" : fn
          #"customer" : {"first_name" : fn.encode("utf-8")}
          # "customer" : {"id" : fn}
        }
    result = chargebee.Subscription.create(d)
    print(result.subscription)
    print(result.customer)
    print(result.customer)
    result = chargebee.Subscription.retrieve(fn)
    print(result.subscription)
    print(result.subscription.id)
    print(result.customer)

def create_sub2(): 
    #fn = u'абвгд'
    fn = raw_input().decode(sys.stdin.encoding or locale.getpreferredencoding(True))
    print(type(fn))
 #   fn = fn.decode("ascii")
    print(type(fn))
    result = chargebee.Subscription.create({
                "plan_id" : "flat-fee-trial",
                #"customer" : {"first_name" : fn.encode("utf-8")}
                "customer" : {"first_name" : fn}
             })
    print(result.subscription)
    print(result.customer)
    print(result.customer.first_name)

def list_subscriptions():
    list = chargebee.Subscription.list({"limit" : 10})
    length = 10
    while list.next_offset is not None:
        print(list.next_offset)
        for entry in list:
            subscription = entry.subscription
            print(subscription)
            customer = entry.customer
            card = entry.card
        list = chargebee.Subscription.list({"limit" : 10, "offset":list.next_offset})
        length = length + len(list)
        print("length is %s", len(list))
 
    print(length)

list_subscriptions()
#create_sub2()
#create_sub()
