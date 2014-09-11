"""
Contains sample codes & functions to work with our php library.
"""
import os,sys
import traceback

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
import httplib
import socket
"""
Use the below settings to configure the api endpoint with specific domain.
"""
Environment.chargebee_domain = "localcb.in:8080"
ChargeBee.verify_ca_certs = False
chargebee.configure("test___dev__KScdxhX6cdv9BbJW3EayQcdxY3xjvcu3PHz", "mannar-test")

try:
    result = chargebee.Subscription.create({
        "plan_id" : "no_trial",
        "coupon"  : "ss", 
        "customer" : {
            "email" : "john@user.com", 
            "first_name" : "John", 
            "last_name" : "Doe", 
            "phone" : "+1-949-999-9999"
        }, 
        "billing_address" : {
            "first_name" : "John", 
            "last_name" : "Doe", 
            "line1" : "PO Box 9999", 
            "city" : "Walnut", 
            "state" : "CA", 
            "zip" : "91789", 
            "country" : "US"
        }, 
        "card" : {
            "gateway" : "chargebee", 
            "first_name" : "Richard", 
            "last_name" : "Fox", 
            "number" : "4012888888881881", 
            "expiry_month" : 10, 
            "expiry_year" : 2015, 
            "cvv" : "999"
         },
        "addons" : [{
            "id" : "ssl"
        }]
    })
    subscription = result.subscription
    print result
except chargebee.PaymentError,ex:
    # First check for user inputted card parameters and show appropriate message.
    # We recommend you to validate the input at the client side itself to catch simple mistakes.
    if "card[number]" == ex.param:
      print "Card number error %s " % ex.api_error_code
      # Ask your user to recheck the card number. A better way is to use 
      # Stripe's https:#github.com/stripe/jquery.payment for validating it in the client side itself.   
      pass
    else:
      print "Other errors %s " % ex.api_error_code
      # Provide a standard message to your user to recheck his card details or provide a different card.
      # Like  'Sorry,there was a problem when processing your card, please check the details and try again'. 
      pass
except chargebee.InvalidRequestError,ex:
    # For coupons you could decide to provide specific messages by using 
    # the 'code' attribute in the ex.
    if "coupon" == ex.param:
      if "resource_not_found" == ex.api_error_code:
        print "Resource not found %s " % ex.api_error_code
        # Inform user to recheck his coupon code.
        pass
      elif "resource_limit_exhausted" == ex.api_error_code:
        # Inform user that the coupon code has expired.
        pass
      elif  "invalid_request" == ex.api_error_code:
        # Inform user that the coupon code is not applicable for his plan(/addons).
        pass
      else:
        # Inform user to recheck his coupon code.
        pass
    else:
      # Since you would have validated all other parameters on your side itself, 
      # this could probably be a bug in your code. Provide a generic message to your users.
      pass    
except chargebee.OperationFailedError,ex:
    print 'Operation failed %s ' % ex.api_error_code
    # Indicates that the request parameters were right but the request couldn't be completed.
    # The reasons might be "api_request_limit_exceeded" or could be due to an issue in ChargeBee side.
    # These should occur very rarely and mostly be of temporary nature. 
    # You could ask your user to retry after some time.
    pass    
except chargebee.APIError,ex:
   print 'APIError Error %s' % ex.api_error_code
   # Handle the other ChargeBee API errors. Mostly would be setup related 
   # Errors such as authentication failure.
   # You could ask users contact your support.
   pass    
except (httplib.HTTPException, socket.error) as ex:
   print 'Http Error %s' % ex.message
   # Handle IO exceptions such as connection timeout, request timeout etc.
   # You could give a generic message to the customer retry after some time.
   pass
except Exception, ex: 
   print traceback.format_exc()
   print type(ex).__name__
   # These are unhandled exceptions (Could be due to a bug in your code or very rarely in client library).
   # You could ask users contact your support.
   pass

