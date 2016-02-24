var chargebee = require("../../node/lib/chargebee.js");


chargebee.configure({site : "mannar-test",
  api_key : "test___dev__UQfnDcdSqPq6enuCRSsLesAp1nSNaz70k", hostSuffix:'.localcb.in', protocol:"http", port:"8080"});


// //Simple Promise Test
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
    state : "California",
    zip : "91789",
    country : "US"
  }
}).request().then(function(result){
  console.log('Result');
  console.log(JSON.stringify(result, null, 2));
}).catch(function(error){
  console.log('Error');
  console.log(error);
});

// //Promise environment Override Test
// chargebee.subscription.create({
//   plan_id : "basic",
//   customer : {
//     email : "john@user.com",
//     first_name : "John",
//     last_name : "Doe",
//     phone : "+1-949-999-9999"
//   },
//   billing_address : {
//     first_name : "John",
//     last_name : "Doe",
//     line1 : "PO Box 9999",
//     city : "Walnut",
//     state : "California",
//     zip : "91789",
//     country : "US"
//   }
// }).request({site : "ajit-test",// making request to live site
//   api_key : "--",hostSuffix:'.chargebee.com', protocol:"https", port:"443"}).then(function(result){
//   console.log('Result');
//   console.log(JSON.stringify(result, null, 2));
// }).catch(function(error){
//   console.log('Error');
//   console.log(error);
// });

// //Promise Chaning Test
// chargebee.subscription.create({
//   plan_id : "basic",
//   customer : {
//     email : "john@user.com",
//     first_name : "John",
//     last_name : "Doe",
//     phone : "+1-949-999-9999"
//   },
//   billing_address : {
//     first_name : "John",
//     last_name : "Doe",
//     line1 : "PO Box 9999",
//     city : "Walnut",
//     state : "California",
//     zip : "91789",
//     country : "US"
//   }
// }).request().then(function(result){
//   console.log("Subscription Created");
//   console.log(JSON.stringify(result, null, 2));
//   return chargebee.address.update({
//       subscription_id : result.subscription.id,
//       label : "shipping_address",
//       first_name : "Benjamin",
//       last_name : "Ross",
//       addr : "PO Box 9999",
//       city : "Walnut",
//       state : "California",
//       zip : "91789",
//       country : "United States"
//     }).request();
// }).then(function(result){
//    console.log("Address Updated");
//    console.log(JSON.stringify(result, null, 2));
// }).catch(function(error){
//   console.log('Error');
//   console.log(error);
// });
