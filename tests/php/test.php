<?php
require '../../php/lib/ChargeBee.php';
ChargeBee_Environment::$scheme = "https";
ChargeBee_Environment::$chargebeeDomain = "stagingcb.com";

//Code from apidocs
ChargeBee_Environment::configure("stagingtesting-2-test",
  "test_b8Zsv1ZhzEIbumcdrijvPC1Nj4q1ZREoq");

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

amazontxn();
//updateCardAmazon();
//retrieveCard();
//retrieveCustomerAmazon();
?>
