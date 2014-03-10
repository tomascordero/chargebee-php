var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({'site': 'mannar-test','api_key': 'test___dev__TDJ7GGjMQ0zvFg4cOcdnnoJSPqkeRQs2a','hostSuffix': '.localcb.in', 'protocol': 'http', 'port': 8080});

chargebee.coupon.create({
  id : "sample_offer1", 
  name : "Sample Offer 1", 
  discount_type : "fixed_amount", 
  discount_amount : 500, 
  apply_on : "each_specified_item", 
  duration_type : "forever",
  plan_constraint:"specific",
  addon_constraint:"none",
  plan_ids:["professional","basic"]
}).request(function(error,result){
  if(error){
    //handle error
    console.log(error);
  }else{
    console.log(result);
    var coupon = result.coupon;
  }
});


