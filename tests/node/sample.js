var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({
    'site': 'honeycomics-test',
    'api_key': 'test_5LjFA6K6doB2EKRP7cufTd5TvT32a5BrT',
//    'hostSuffix': '.localcb.in',
//    'protocol': 'http',
//    'port': 8080
});

var callback = function(error, result) {
    if (error) {
        //handle error
        console.log(error);
    } else {
        console.log(result);
    }
}

function createCoupon() {
    chargebee.coupon.create({
        id: "sample_offer1",
        name: "Sample Offer 1",
        discount_type: "fixed_amount",
        discount_amount: 500,
        apply_on: "each_specified_item",
        duration_type: "forever",
        plan_constraint: "specific",
        addon_constraint: "none",
        plan_ids: ["professional", "basic"]
    }).request(callback);
}

function createPortalSession() {
    chargebee.portal_session.create({
        customer:{id: "__dev__XpbGUFcOfUyJC41"},
        redirect_url: "https://www.chargebee.com/thanks.html"
    }).request(callback);
}

function createSubForCust(custId) {
	chargebee.subscription.create_for_customer(custId, {
	  plan_id : "basic"
	}).addHeaders({
		"chargebee-event-email" : "all-disabled"
	}).request(callback);
}

function retrievePortalSession(sessionId) {
    chargebee.portal_session.retrieve(sessionId).request(callback);
}

function logoutPortalSession(sessionId) {
    chargebee.portal_session.logout(sessionId).request(callback);
}

function createOrder(invId) {
    chargebee.order.create({
        invoice_id : invId,
        status : "new",
        fulfillment_status : "Shipped"
    }).request(callback);
}

function retrieveOrder(orderId) {
    chargebee.order.retrieve(orderId).request(callback);
}

function updateOrder(orderId) {
    chargebee.order.update(orderId, {
        status : "processing"
    }).request(callback);
}

function listOrders() {
    chargebee.order.list({limit:"5"}).request(callback);
}

function listInvOrders(invId) {
    chargebee.order.orders_for_invoice(invId, {limit: "5"}).request(callback);
}


function createSub() {
   chargebee.subscription.create({
         plan_id : "yearly",
         customer : {
              first_name : "john",
              last_name : "doe",
              email : "john@acmeinc.com",
              allow_direct_debit : "true",
              auto_collection : "off"
         }
   }).request(callback);
}

function createCustomer() {
  chargebee.customer.create({
    first_name : "Bruce",
    last_name : "Wayne",
    email : "bruce@wayneenterprises.com",
    allow_direct_debit : "TRUE "
  }).request(callback);
}

function updateCustomer() {
  chargebee.customer.update("1sjs9jGPRumO0ZLbA",
     {first_name : "Bruce",
     last_name : "Wayne",
     email : "asd@AS.com",
     allow_direct_debit : "True"
  }).request(callback);
}


function createSubEstimate() {
  chargebee.estimate.create_subscription({
    subscription: { 
            plan_id : "silver",
            coupon : " ", 
    },
    "billing_address" : {
        country : "INDIA",
        state_code : "TN",
        zip : "600001",
    }
//    "shipping_address" : {
//       country : "US",
//       state_code : "CA"
//    }  
  }).request(function(error,result){
    console.log(result);
    console.log(result.estimate.line_items) ;
  });
}

function updateEstimate() {
  chargebee.estimate.update_subscription({
     subscription : { 
         id : "2rprAVhzPRkSC3T2dr",
         plan_id  : "silver"
     },
     billing_address : {
        country : "Inida",
        state_code : "TN"
     },
     shipping_address : {
         country :"US",
         zip_code : "91789"
     }       
  }).request(callback);
}


updateEstimate();
//createSubEstimate();
//updateCustomer();
//createCustomer();
//createSub();

// createCoupon();

// createPortalSession();
// retrievePortalSession('__dev__eCPtmvdeIra67bYcdcdDz9iXtELg84LNcdcd');
// logoutPortalSession('__dev__cdI6S8UwccR2I8uvMy7cuYZ3GZm8y6xDAI');

// createOrder("__demo_inv__23");
// retrieveOrder("__dev__XpbGU6hOxHqreZ1");
// updateOrder("__dev__XpbGU6hOxHqreZ1");
// listOrders();
// listInvOrders("__demo_inv__8");
// createSubForCust("cust_handle");
