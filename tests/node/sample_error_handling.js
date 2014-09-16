var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({'site': 'mannar-test', 'api_key': 'test___dev__KScdxhX6cdv9BbJW3EayQcdxY3xjvcu3PHz', 'hostSuffix': '.localcb.in', 'protocol': 'http', 'port': 8080});


//The callback function that you provide needs to take in two arguments. The first being error object and the 
//second being the response. Incase of error, the error object is passed.
chargebee.subscription.create({
  plan_id : "basic", 
  //coupon:"ss",
  customer : {
    email : "john@user.com", 
    first_name : "John", 
    last_name : "Doe", 
    phone : "+1-949-999-9999"
  }, 
  billing_address : {
    first_name : "John", 
    last_name : "Doe", 
    line1 : "PO Box 9999", 
    city : "Walnut", 
    state : "CA", 
    zip : "91789", 
    country : "US"
  },
  card: {
  gateway : "chargebee", 
  first_name : "Richard", 
  last_name : "Fox", 
  number : "4012888888881881", 
  expiry_month : 10, 
  expiry_year : 2015, 
  cvv : "999"
}
}).request(function(error, result) {
  if (error) {
    handleCreateSubscriptionError(error);
  } else {
    console.log(result);
  }
});

function handleCreateSubscriptionError(ex) {
  console.log(ex);
  if (ex.type == "payment") {
    //First check for user inputted card parameters and show appropriate message.
    //We recommend you to validate the input at the client side itself to catch simple mistakes.
    if ("card[number]" == ex.param) {
        console.log("In card");
      // Ask your user to recheck the card number. A better way is to use 
      // Stripe's https://github.com/stripe/jquery.payment for validating it in the client side itself.   
    } else {
       console.log("In payment other ");
      //Provide a standard message to your user to recheck his card details or provide a different card.
      // Like  'Sorry,there was a problem when processing your card, please check the details and try again'. 
    }

  } else if (ex.type == "invalid_request") {
    console.log("In invalid_request");
    // For coupons you could decide to provide specific messages by using 
    // the 'code' attribute in the ex.
    if ("coupon" == ex.param) {
      if ("resource_not_found" == ex.api_error_code) {
        console.log("resource_not_found");
        // Inform user to recheck his coupon code.
      } else if ("resource_limit_exhausted" == ex.api_error_code) {
        // Inform user that the coupon code has expired.
      } else if ("invalid_request" == ex.api_error_code) {
        // Inform user that the coupon code is not applicable for his plan(/addons).
      } else {
        // Inform user to recheck his coupon code.
      }
    } else {
      // Since you would have validated all other parameters on your side itself, 
      // this could probably be a bug in your code. Provide a generic message to your users.
    }
    //Ask the user to recheck his card details or provide a different card.  
  } else if (ex.type == "operation_failed") {
    console.log("In operation failed");
    // Indicates that the request parameters were right but the request couldn't be completed.
    // The reasons might be "api_request_limit_exceeded" or could be due to an issue in ChargeBee side.
    // These should occur very rarely and mostly be of temporary nature. 
    // You could ask your user to retry after some time.
  } else if (ex.type == "io_error") {
    console.log("In IO");
    // Handle IO exceptions such as connection timeout, request timeout etc.
    // You could give a generic message to the customer retry after some time.
  } else {
    console.log("In unhandled");
    // These are unhandled exceptions (Could be due to a bug in your code or very rarely in client library).
    // The errors from ChargeBee such as authentication failures will come here.
    // You could ask users contact your support.
  }
}
