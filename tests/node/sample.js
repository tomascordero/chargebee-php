var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({
	'site': 'mannar-test',
    'api_key': 'test___dev__vfcuZyxcu2YH51J1siLcdxiXlg8pVknqArD',
	'hostSuffix': '.localcb.in',
   'protocol': 'http',
   'port': 8080
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

function retrieveCustomer() {
	chargebee.customer.retrieve("future_billing").request(
	function(error,result){
	  if(error){
	    //handle error
	    console.log(error);
	  }else{
	    console.log(JSON.stringify(result, null, 2));
	    var customer = result.customer;
	    var card = result.card;
	  }
	});
}

function retrieveInv() {
	chargebee.invoice.retrieve("111").request(
	function(error,result){
	  if(error){
	    console.log(error);
	  }else{
		console.log(result.invoice.linked_transactions);
	  }
	});
}

function retrieveTxn() {
	chargebee.transaction.retrieve("txn_2rprAVk1PTWCKikIPP").request(
	function(error,result){
	  if(error){
		  console.log(error);
	  }else{
	    console.log(result.transaction.linked_invoices);
	  }
	});
}

function retrieveEvent() {
	chargebee.event.retrieve("ev_BfmoYxPTWF2XoFuB").request(
	function(error,result){
	  if(error){
		  console.log(error);
	  }else{
	    console.log(result.event.content.transaction);
	  }
	});
}

function addContact(){
    chargebee.customer.add_contact("future_billing", {
    contact : {
        first_name : "Jane", 
        last_name : "Doe", 
        email : "jane@test.com", 
        label : "dev", 
        enabled : true, 
        send_billing_email : true, 
        send_acccount_email : true
      }
    }).request(function(error,result){
      if(error){
        //handle error
        console.log(error);
      }else{
        console.log(result);
        var customer = result.customer;
        var card = result.card;
      }
    });
}

function updateContact(){
    chargebee.customer.update_contact("future_billing", {
    contact : {
        id : "contact___dev__3Nl8EMyPa7SDNw1", 
        first_name : "John", 
        last_name : "Doe", 
        email : "john@test.com", 
        label : "dev", 
        enabled : true, 
        send_billing_email : false, 
        send_acccount_email : true
      }
    }).request(function(error,result){
      if(error){
        //handle error
        console.log(error);
      }else{
        console.log(JSON.stringify(result, null, 2));
        var customer = result.customer;
        var card = result.card;
      }
    });
}
function deleteContact(){
    chargebee.customer.delete_contact("future_billing", {
    contact : {
        id : "contact___dev__3Nl8EMyPa7SDNw1"
      }
    }).request(function(error,result){
      if(error){
        //handle error
        console.log(error);
      }else{
        console.log(JSON.stringify(result, null, 2));
        var customer = result.customer;
        var card = result.card;
      }
});
}

// addContact();
// updateContact();
// deleteContact();
// updateEstimate();
// retrieveCustomer();
// retrieveInv();
// retrieveTxn();
// retrieveEvent();
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
