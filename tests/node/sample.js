var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({
    'site': 'mannar-test',
    'api_key': 'test___dev__0hcdH60Wi8x2CLOzfsC7AVsDYlfYnbwy7',
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