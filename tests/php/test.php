<?
require '../../php/lib/ChargeBee.php';
ChargeBee_Environment::$chargebeeDomain = "localcb.in";

//Code from apidocs
ChargeBee_Environment::configure("mannar-test",
  "__dev__YlRMjamvRnwhK8sDYN8miacuJSpSH3EfK");
$result = ChargeBee_Customer::updateBillingInfo("active_direct", array(
  "billing_address" => array(
    "addressLine1" => "340 S LEMON AVE #1537", 
    "city" => "Walnut", 
    "state" => "CA", 
    "zip" => "91789", 
    "country" => "US"
  )));
$customer = $result->customer();


//Test
print $customer->billingAddress->country;
?>
