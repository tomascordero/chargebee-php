<?php
require '../../php/lib/ChargeBee.php';
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

//Code from apidocs
ChargeBee_Environment::configure("mannar-test",
  "test___dev__6FbsRDbxnOQQqfWSQlAcCWrgxQGgywma");

function retrieveCustomerAmazon(){
 //$result = ChargeBee_Customer::retrieve("1sGeZ2FOvHp6wJ2k");
 $result = ChargeBee_Customer::retrieve("1sGeZ2FOvHb5cF1I");
 var_dump($result->customer());
 var_dump($result->card());
 var_dump($result->customer()->paymentMethod); 
 var_dump($result->customer()->paymentMethod->status); 
 var_dump($result->customer()->paymentMethod->referenceId); 
 var_dump($result->customer()->paymentMethod->type); 
}


function retrieveCard() {
 //$result = ChargeBee_Card::retrieve("1sGeZ2FOvI0H2E4y");
 $result = ChargeBee_Card::retrieve("1sGeZ2FOvHb5cF1I");
 var_dump($result);
 var_dump($result->card());
}

function updateCardAmazon() {
 $result = ChargeBee_Card::updateCardForCustomer("1sGeZ2FOvHp6wJ2k", array(
  "gateway" => "chargebee", 
  "firstName" => "Richard", 
  "lastName" => "Fox", 
  "number" => "4012888888881881", 
  "expiryMonth" => 10, 
  "expiryYear" => 2015, 
  "cvv" => "999"));
 var_dump($result);
 var_dump($result->customer());
 var_dump($result->card());
 var_dump($result->customer()->paymentMethod);
 var_dump($result->customer()->paymentMethod->status);
 var_dump($result->customer()->paymentMethod->type);
 var_dump($result->customer()->paymentMethod->reference_id);
}

function amazontxn(){
 //$result = ChargeBee_Transaction::retrieve("txn_1sGeZ2FOvHzDwG4Y");
 $result = ChargeBee_Transaction::retrieve("txn_1sGeZ2FOvI530V5R");
 $transaction = $result->transaction();
 var_dump($transaction);
 var_dump($transaction->paymentMethod);
 var_dump($transaction->type);
}

function retriveiFrameHp() {
$result = ChargeBee_HostedPage::checkoutNew(array(
  "subscription" => array(
    "planId" => "cbee_multiple_site_plan"
  ),
  "iframeMessaging" => "true"
 ));

echo $result->hostedpage()->url;
}

retriveiFrameHp();
//amazontxn();
//updateCardAmazon();
//retrieveCard();
//retrieveCustomerAmazon();
?>
