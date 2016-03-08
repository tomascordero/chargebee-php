<?php

/**
 * Require the chargebee-php library from the code base that is relative to the
 * chargebee-app directory
 */
require('../../php/lib/ChargeBee.php');

/**
 * Below are the setting to be used if you are testing with the local server.
 */
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

ChargeBee_Environment::configure("mannar-test", "test___dev__cuwdrqzezGcuMOcL44LvcdWiyccdOkizHuAX");


$id = "__dev__3Nl8GwLPT2putC4";
#$id = "   __dev__3Nl8GwLPT2putC4   ";
//$t = trim($t);
//if($t == null) {
// print("null");
//}
//print($t);

#$id = null;
#$id = " ";

$result = ChargeBee_Subscription::retrieve($id);
print_r($result);

$all = ChargeBee_Subscription::subscriptionsForCustomer($id);
foreach($all as $entry){
  $subscription = $entry->subscription();
  print_r($subscription);
}

?>
