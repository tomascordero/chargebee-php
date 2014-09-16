<?php
require '../../../chargebee-php/lib/ChargeBee.php';
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

ChargeBee_Environment::configure("mannar-test","test___dev__NqcddV3mrcu9pWqcyacuq0twyYyXXPrVlcuj");

function printError($e) {
   echo "OLD ERRORS\n";
   $errorJSON = $e->getJSONObject();
   echo $errorJSON["error_code"] . "\n";
   echo $errorJSON["error_msg"] . "\n";
   echo $errorJSON["http_status_code"] . "\n";
   if( isset($errorJSON["error_param"])) {
     echo $errorJSON["error_param"] . "\n"; 
   }
   echo "NEW ERRORS\n";
   echo $errorJSON["type"] . "\n"; 
   echo $errorJSON["api_error_code"] . "\n";
   echo $errorJSON["message"] . "\n";
   echo $errorJSON["http_status_code"] . "\n";
   if( isset($errorJSON["param"]) ) {
     echo $errorJSON["param"] . "\n";
   }
   echo json_encode($errorJSON) . "\n"; 
}

function createSub() {
try{
 $result = ChargeBee_Subscription::create(array(
  "planId" => "flat_fee", 
 "plan_quantity" => "2",
//  "coupon" => "plan_only_coupon",
  "customer" => array(
    "email" => "john@user.com", 
//    "firstName" => "John asdasdabk asjbdakjshbd asjbdkjahs akjbsdsak aBDBSFLDSBF  asdbflas asdasda asdhjasbkf asdhfjbjkhadsas asdasd asdahbdaks askdbsakjd akjsdnsjnad asjdnsad dadnsadnbaloiwerywer asbajkbauiewr asbbasoweru", 
    "lastName" => "Doe", 
    "phone" => "+1-949-999-9999",
  ), 
  "billingAddress" => array(
    "firstName" => "John", 
    "lastName" => "Doe", 
    "line1" => "PO Box 9999", 
    "city" => "Walnut", 
    "state" => "CA", 
    "zip" => "91789", 
    "country" => "US"
  ), 
/*  "card" => array( 
    "number" => "4111111111111111",
    "expiry_month" => "12",
    "expiry_year" => "2014"
  )*/
//  "addons" => array(array(
//    "id" => "ssl"
//  )) 
  ));
 echo "success\n";
} catch(ChargeBee_APIError $e) {
  printError($e);
}

}

function updateSubscription() {
 try {
  $result = ChargeBee_Subscription::update("__dev__XpbG8HXOpwEt9RQ", array(
           "planId" => "professional", 
         //  "planQuantity" => "3",
          "coupon" => "plan_coupon",
           "billingAddress" => array(
                   "firstName" => "John", 
                   "lastName" => "Doe", 
                   "line1" => "PO Box 9999", 
                   "city" => "Walnut", 
                   "state" => "CA", 
                   "zip" => "91789", 
                   "country" => "US"
             ), 
             "addons" => array(array(
                   "id" => "day_pass",
                   "quantity" => "2"
             ))
   ));
   echo "success\n";
 } catch(ChargeBee_APIError $e) {
   printError($e);
 }
}

function cancelSub() {
try {
  $result = ChargeBee_Subscription::cancel("future_billing");
  echo "api call success";
} catch(ChargeBee_APIError $e) {
 printError($e);
}
}
function hostedPages() {
 try {
  $result = ChargeBee_HostedPage::checkoutNew(array(
  "subscription" => array(
    "planId" => "basic",
    "coupon" => "plan_coupon"
  ), 
  "customer" => array(
    "email" => "john@user.com", 
    "firstName" => "John", 
    "lastName" => "Doe", 
    "phone" => "+1-949-999-9999"
  ) 
//  "addons" => array(array(
//    "id" => "sslaaa"
//    "quantity" => "2"
//  ))
   ));
  echo "success\n";
 } catch(ChargeBee_APIError $e) {
   printError($e); 
 }
}


function checkoutExisting() {
try {
 $result = ChargeBee_HostedPage::checkoutExisting(array(
  "subscription" => array(
    "id" => "__dev__XpbG8HXOpwEt9RQ", 
    "planId" => "flat_fee",
    "planQuantity" => "3"
  )
 /* "addons" => array(array(
    "id" => "ssl"
  )) */
 ));
 echo "success"; 
} catch(ChargeBee_APIError $e) {
 printError($e);
}
}

function createInvoiceForCharge() {
 try {
  $result = ChargeBee_Invoice::charge(array(
       "subscriptionId" => "active_direct", 
       "amount" => "1000asdsa", 
       "description" => "Support charge"));
    echo "success";
  } catch(ChargeBee_APIError $e) {
    printError($e);
  }
}

function createInvoiceForAddon() {
 try {
  $result = ChargeBee_Invoice::chargeAddon(
               array("subscriptionId" => "active_direct",
                     "addonId" => "day_pass",
                     "addonQuantity" => "asd2"));
  echo "success";                             
 } catch(ChargeBee_APIError $e) {
  printError($e);
 }
}

function listEvents() {
try {
 $all = ChargeBee_Event::all(array(
       "limit" => 5, 
       "startTime" => 1388534400, 
       "endTime" => 1325376000));
  echo "success";
} catch( ChargeBee_APIError $e) {
  printError($e);
}
}


//createSub()
//cancelSub()
//updateSubscription()
//hostedPages()
//checkoutExisting()
//createInvoiceForCharge()
//createInvoiceForAddon()
listEvents()
?>
