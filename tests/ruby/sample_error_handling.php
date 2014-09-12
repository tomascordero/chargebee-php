<?php

/**
 * Contains sample codes & functions to work with our php library.
 */
/**
 * Require the chargebee-php library from the code base that is relative to the
 * chargebee-app directory
 */
require('../../php/lib/ChargeBee.php');

/**
 * Below are the setting to be used if you are testing with the local server.
 */
ChargeBee_Environment::$scheme = "http";
//ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";
ChargeBee_Environment::$chargebeeDomain = "freshdesk.com";


/**
 * Below are the configuration setting our customers will use to connect to our production server.
 */
//ChargeBee_Environment::$chargebeeDomain = "stagingcb.com";
//ChargeBee_Environment::configure("mannar-test", "test___dev__dJIiuf4qr6gcuTiPLiBSY1Zm40o4vcdFA");

ChargeBee_Environment::configure("mannar-test", "test___dev__QFEb5bUtAHYudl124Lcu7tYrEm3NZWonN");

try {
    print(" Here ");
    $result = ChargeBee_Subscription::create(array(
                "planId" => "no_trial",
                "coupon" => "fsfs",
                "customer" => array(
                    "email" => "john@user.com",
                    "firstName" => "John",
                    "lastName" => "Doe",
                    "phone" => "+1-949-999-9999"
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
                "addons" => array(array(
                        "id" => "ssl"
    ))));
    $subscription = $result->subscription();
    print_r($subscription);
} catch (ChargeBee_PaymentException $ex) {
    print(" 11Here ");
    //First check for specific card parameter names and show appropriate message.
    //We recommend you to validate the input at the client side itself to catch simple mistakes.
    if ("card[number]" == $ex->getParam()) {
        // Ask your user to recheck the card number. A better way is to use 
        // Stripe's https://github.com/stripe/jquery.payment for validating it in the client side itself.   
    } else {
        //Provide a standard message to your user to recheck his card details or provide a different card.
        // Like  'Sorry,there was a problem when processing your card, please check the details and try again'. 
    }
} catch (ChargeBee_InvalidRequestException $ex) {
    // For coupons you could decide to provide specific messages by using 
    //the 'code' attribute in the  error.
    if ("coupon" == $ex->getParam()) {
        if ("resource_not_found" == $ex->getApiErrorCode()) {
            print("Inside coupon cool ");
            // Inform user to recheck his coupon code.
        } else if ("resource_limit_exhausted" == $ex->getApiErrorCode()) {
            // Inform user that the coupon code has expired.
        } else if ("invalid_request" == $ex->getApiErrorCode()) {
            // Inform user that the coupon code is not applicable for his plan(/addons).
        } else {
            // Inform user to recheck his coupon code.
        }
    } else {
        // Since you would have validated all other parameters on your side itself, 
        // this could probably be a bug in your code. Provide a generic message to your users.
    }
} catch (ChargeBee_OperationFailedException $ex) {
    // Indicates that the request parameters were right but the request couldn't be completed.
    // The reasons might be "api_request_limit_exceeded" or could be due to an issue in ChargeBee side.
    // These should occur very rarely and mostly be of temporary nature. 
    // You could ask your user to retry after some time.
    print("Operation Feild Error " . $ex->getMessage());
    print_r($ex->getJsonObject());
} catch (ChargeBee_APIError $ex) {
    // Handle the other ChargeBee API errors. Mostly would be setup related 
    // exceptions such as authentication failure.
    // You could ask users contact your support.
    print("Api Error " . $ex->getMessage());
    print_r($ex->getJsonObject());
} catch (ChargeBee_IOException $ex) {
    // Handle IO exceptions such as connection timeout, request timeout etc.
    // Possibly temporary . You could give a generic message to the customer to retry after sometime.
    // The php client library uses curl_exec internally. If you prefer to handle the errors specifically
    // please take a look at http://curl.haxx.se/libcurl/c/libcurl-errors.html
    print("Curl Error Code is: " . $ex->getCurlErrorCode());
} catch (Exception $ex) {
    print("1323" . $ex->getMessage());
    // These are unhandled exceptions (Could be due to a bug in your code or very rarely 
    // in client library). You could ask users contact your support.
}

