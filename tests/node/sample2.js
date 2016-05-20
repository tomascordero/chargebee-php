var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({
	'site': 'mannar-test',
    'api_key': 'test___dev__lo2w917cu5a6GxS3K4HfPFBM1zYP3URYc',
	'hostSuffix': '.localcb.in',
   'protocol': 'http',
   'port': 8080
});

var callback = function(error, result) {
    if (error) {
        //handle error
        console.log(error);
    } else {
      for(var i = 0; i < result.list.length;i++){
      var entry=result.list[i]
      console.log(entry);
    }
    }
}

function createPlan(){
  chargebee.plan.list({
  "price[between]" : [900,1000],
  "id[in]" : ["basic","professional"],
  "period_unit[is]" : "month"
}).request(callback);
}

createPlan()