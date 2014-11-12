import os,sys
sys.path.insert(0,os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python"))
#print os.path.join(os.path.dirname(os.path.abspath(__file__)),"../../python")
import chargebee
from chargebee.main import Environment
Environment.chargebee_domain="stagingcb.com"
Environment.protocol = "https"
chargebee.ChargeBee.verify_ca_certs=False

##Copy code from api docs
chargebee.configure("test_b8Zsv1ZhzEIbumcdrijvPC1Nj4q1ZREoq","stagingtesting-2-test")


def customer_retrieve():
   #result = chargebee.Customer.retrieve("1sGeZ2FOvI0H2E4y")
   result = chargebee.Customer.retrieve("1sGeZ2FOvHb5cF1I")
   print result.customer
   print result.card
   print result.customer.payment_method
   print result.customer.payment_method.status
   print result.customer.payment_method.reference_id
   print result.customer.payment_method.type 


def retrieve_card():
  result = chargebee.Card.retrieve("1sGeZ2FOvI0H2E4y")
  #result = chargebee.Card.retrieve("1sGeZ2FOvHb5cF1I")
  card = result.card
  print result.card


def update_card_amazon():
   result = chargebee.Card.update_card_for_customer("1sGeZ2FOvHb5cF1I", {
     "gateway" : "chargebee", 
     "first_name" : "Richard", 
     "last_name" : "Fox", 
     "number" : "4012888888881881", 
     "expiry_month" : 10, 
     "expiry_year" : 2015, 
     "cvv" : "999"
   }) 
   print result.customer
   print result.card
   print result.customer.payment_method
   print result.customer.payment_method.reference_id
   print result.customer.payment_method.type


def amazon_txn():
 result = chargebee.Transaction.retrieve("txn_1sGeZ2FOvHzDwG4Y")
 #result = chargebee.Transaction.retrieve("txn_1sGeZ2FOvI530V5R")
 print result
 print result.transaction
 print result.transaction.payment_method 

amazon_txn()
#retrieve_card()
#update_card_amazon()
#customer_retrieve()
