var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({'site': 'mannar-test','api_key': 'test___dev__TDJ7GGjMQ0zvFg4cOcdnnoJSPqkeRQs2a','hostSuffix': '.localcb.in', 'protocol': 'http', 'port': 8080});

chargebee.subscription.create({
  plan_id : "basic", 
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
  addons : [{
    id : "ssl"
  }]
}).request(function(error,result){
  if(error){
    //handle error
    console.log(error);
  }else{
    console.log(result.subscription.addons);
    var subscription = result.subscription;
    var customer = result.customer;
    var card = result.card;
    var invoice = result.invoice;
  }
});
