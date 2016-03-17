import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="stagingcb.com"
Environment.protocol = "https"
#chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test_b8Zsv1ZhzEIbumcdrijvPC1Nj4q1ZREoq","stagingtesting-2-test")

def create_subscription():
 result = chargebee.Subscription.create({
    "plan_id" : "no-trial",
    "customer" : {
        "email" : "john@user.com",
        "first_name" : "John",
        "last_name" : "Doe",
        "phone" : "+1-949-999-9999",
        "auto_collection" : "off"
     }})
 print(result)


def list_subscriptions():
    list = chargebee.Subscription.list({"limit" : 100})
    length = 10
    while list.next_offset is not None:
        print(list.next_offset)
        for entry in list:
            subscription = entry.subscription
            print(subscription)
            customer = entry.customer
            card = entry.card
        list = chargebee.Subscription.list({"limit" : 100, "offset":list.next_offset})
        length = length + len(list)
        print("length is %s", len(list))

    print(length)

create_subscription()
list_subscriptions()
