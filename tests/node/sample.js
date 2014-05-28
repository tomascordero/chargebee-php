var chargebee = require("../../node/lib/chargebee.js");

chargebee.configure({
    'site': 'mannar-test',
    'api_key': 'test___dev__jxZfUdzLkEQDso1wJvUM5TzwMfi91H67',
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

function retrievePortalSession(sessionId) {
    chargebee.portal_session.retrieve(sessionId).request(callback);
}

function logoutPortalSession(sessionId) {
    chargebee.portal_session.logout(sessionId).request(callback);
}

// createCoupon();

// createPortalSession();
// retrievePortalSession('__dev__eCPtmvdeIra67bYcdcdDz9iXtELg84LNcdcd');
// logoutPortalSession('__dev__cdI6S8UwccR2I8uvMy7cuYZ3GZm8y6xDAI');