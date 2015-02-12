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
chargebee.configure("test___dev__NgweVXGDQfsY10iCdmcuXkjwgK16QpUja", "mannar-test")


def create_plan(plan_attr):
    try:
        result = chargebee.Plan.create(plan_attr)
        return result.plan 
    except chargebee.InvalidRequestError as ex:
        if ex.api_error_code == "duplicate_entry":
            return chargebee.Plan.retrieve(plan_attr.get("id")).plan
        else:
            raise ex
       
       
def flat_fee_plan_with_trial():
    flat_fee_trial_param = {
                   "id" : "flat-fee-trial",
                   "name":"Flat fee with trial",
                   "invoice_name":"Flat fee with trial",
                   "description":"Description about flat fee plan with trial period",
                   "trial_period":1,
                   "trial_period_unit":"month",
                   "period":2,
                   "period_unit":"month",
                   "price":4000,
                   "setup_cost":200,
                   "charge_model":"flat_fee",
                   "redirect_url":"http://cbdemo.com/mock.jsp"
    }
    return create_plan(flat_fee_trial_param)

def flat_fee_no_trial():
    flat_fee_no_trial_param = {
                   "id" : "flat-fee-no-trial",
                   "name":"Flat fee with no trial",
                   "invoice_name":"Flat fee with no trial",
                   "description":"Description about flat fee plan with trial period",
                   "period":1,
                   "period_unit":"month",
                   "price":6000,
                   "setup_cost":200,
                   "charge_model":"flat_fee",
                   "redirect_url":"http://cbdemo.com/mock.jsp"
    }
    return create_plan(flat_fee_no_trial_param)
 
class TestCases(unittest.TestCase):
     
     @classmethod
     def setUpClass(self):
         self.flat_fee_with_trial = flat_fee_plan_with_trial()
         self.flat_fee_no_trial = flat_fee_no_trial()
     
     
     def test_create_subscription(self):
        result = chargebee.Subscription.create({ 
            "plan_id" : self.flat_fee_with_trial.id,        
            "customer" : {
                "first_name" : "John",
                "last_name" : "Doe"
            }
        })
        subscription_id = result.subscription.id
        
     
     def test_update_subscription(self):
         result = chargebee.Subscription.create({
            "plan_id" : self.flat_fee_with_trial.id,
            "customer" : {
                "first_name" : "update",
                "last_name" : "customer"
            }
         })
         subscription_id = result.subscription.id
         
         result1 = chargebee.Subscription.update(subscription_id, {
             "plan_id" : self.flat_fee_no_trial.id,
             "card" : {
                 "number" : "4111111111111111",
                 "expiry_month" : 9,
                 "expiry_year" : 2024
             }
         })
         self.failUnless(result1.card != None )
           
          
     def test_checkout_new(self):
        result = chargebee.HostedPage.checkout_new({
            "subscription" : {
                "plan_id" : self.flat_fee_no_trial.id,
            },
            "embed" : "false"
        })
        print("Is checkout done for the URL done?\n",result.hosted_page.url)
        if sys.version_info[0] == 3:
            user_input = input()
        else:
            user_input = raw_input()
        while(True):
            if user_input == "y" :
                result1 = chargebee.HostedPage.retrieve(result.hosted_page.id)
                self.assertEqual(result1.hosted_page.state, "succeeded")
                break
            
            
     def test_checkout_existing(self):
         result = chargebee.Subscription.create({
             "plan_id" : self.flat_fee_with_trial.id
         })
         result1 = chargebee.HostedPage.checkout_existing({
             "subscription" : {
                 "id" : result.subscription.id
             },
             "embed" : "false"
         })
         print("Is checkout done for the URL done?",result1.hosted_page.url)
         if sys.version_info[0] == 3:
             user_input = input()
         else:
             user_input = raw_input()
         while(True):
             if user_input == "y" :
                 result2 = chargebee.Subscription.retrieve(result.subscription.id)
                 self.failUnless(result2.card != None )
                 break

if __name__ == "__main__":
   unittest.main() 


