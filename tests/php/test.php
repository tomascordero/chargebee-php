<?php
require '../../php/lib/ChargeBee.php';
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

//Code from apidocs
ChargeBee_Environment::configure("mannar-test",
  "test___dev__dJIiuf4qr6gcuTiPLiBSY1Zm40o4vcdFAT");

function testParams() {
 $result = ChargeBee_Subscription::retrieve('active_direct');
// print_r($result);
//print_r($result->subscription()->currentTermEnasdd);
//print_r($result->customer());
//print_r($result->customer()->cfDateOfBirth);
//print_r($result->customer()->cfGender);
print_r($result->customer()->cfSocialSecurityNo);
}

testParams();

//$var = "cfDateOfBirth";
//print_r(substr($var,0,2));
?>
