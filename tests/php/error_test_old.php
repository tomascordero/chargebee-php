<?php
require '../../php/lib/ChargeBee.php';
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

ChargeBee_Environment::configure("mannar-test","test___dev__NqcddV3mrcu9pWqcyacuq0twyYyXXPrVlcuj");

function createSub() {
try{
 $result = ChargeBee_Subscription::create(array(
  "planId" => "flat_fee", 
//  "plan_quantity" => "2",
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
  var_dump($e->getJSONObject());
}

}


function hostedPages() {
try {
 $result = ChargeBee_HostedPage::checkoutNew(array(
  "subscription" => array(
    "planId" => "basic",
//   "coupon" => "max_redem"
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
  var_dump($e->getJSONObject());
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
    var_dump($e->getJSONObject());
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
  var_dump($e->getJSONObject());
 }
}

//createSub();
//hostedPages();
//createInvoiceForCharge()
createInvoiceForAddon()

?>
