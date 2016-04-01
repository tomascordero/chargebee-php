import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="localcb.in:8080"
Environment.protocol = "http"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test___dev__yuYlT1jLI4AXhwZpF3cuGModbc127lfOw","mannar-test")

f = open("./sample_event.json","r")
content = f.read()
print content

event = chargebee.Event.deserialize(content)
print event.id

