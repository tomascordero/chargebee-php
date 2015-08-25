<?php

require('../ChargeBee.php');

function test($respJson){
		array($respJson, '');
		$resp = json_decode($respJson, true);
		$res = new ChargeBee_Result($resp);
		$est = $res->estimate();
		print_r($est);
		// print_r($est->invoiceEstimate);
		// print_r($est->invoiceEstimate->lineItems[0]);
}

$sub =  '{
    "subscription": {
        "id": "KyVrKRPHl5UT33q",
        "plan_id": "basic",
        "plan_quantity": 1,
        "status": "in_trial",
        "trial_start": 1436275944,
        "trial_end": 1438954344,
        "created_at": 1436275944,
        "started_at": 1436275944,
        "has_scheduled_changes": false,
        "object": "subscription",
        "due_invoices_count": 0
    },
    "customer": {
        "id": "KyVrKRPHl5UT33q",
        "first_name": "John",
        "last_name": "Doe",
        "email": "john@user.com",
        "phone": "+1-949-999-9999",
        "auto_collection": "on",
        "created_at": 1436275944,
        "object": "customer",
        "billing_address": {
            "first_name": "John",
            "last_name": "Doe",
            "line1": "PO Box 9999",
            "city": "Walnut",
            "state_code": "CA",
            "state": "California",
            "country": "US",
            "zip": "91789",
            "object": "billing_address"
        },
        "card_status": "no_card",
        "account_credits": 0
    },
    "invoices": [{
		"id": "1",
	    "customer_id": "8avVGOkx8U1MX",
	    "subscription_id": "8avVGOkx8U1MX",
	    "recurring": true,
	    "status": "paid",
	    "start_date": 1317407411,
	    "end_date": 1320085811,
	    "amount": 900,
	    "amount_due": 0,
	    "currency_code": "USD",
	    "paid_on": 1320085812,
	    "object": "invoice",
	    "sub_total": 900,
	    "tax": 0,
	    "line_items": [{
	            "date_from": 1320085811,
	            "date_to": 1322677811,
	            "unit_amount": 900,
	            "quantity": 1,
	            "tax": 0,
	            "object": "line_item",
	            "amount": 900,
	            "description": "Basic",
	            "type": "charge",
	            "entity_type": "plan",
	            "entity_id": "basic"
	        }],
	    "linked_transactions": [{
	            "txn_id": "txn_KyVr8xPHl5Bjg8",
	            "applied_amount": 900,
	            "txn_type": "payment",
	            "txn_status": "success",
	            "txn_date": 1320085812,
	            "txn_amount": 900
	        }],
	    "linked_orders": [{
	            "id": "XpbG8t4OvwWgjzM",
	            "status": "processing",
	            "reference_id": "1002",
	            "fulfillment_status": "Awaiting Shipment",
	            "created_at": 1436275881
	        }],
	    "billing_address": {
	        "first_name": "Benjamin",
	        "last_name": "Ross",
	        "object": "billing_address"
	    }
		}]
}';

$estimate =  '{"estimate": {
    "created_at": 1436275938,
	"subscription_status": "in_trial",
	"subscription_id": "gf45sajhjhga656sa",
    "subscription_next_billing_at": 1438954338,
	"object": "estimate",
	"invoice_estimate": {
		"recurring": true,
	    "collect_now": false,
	    "sub_otal": 500,
		"total": 900,
		"amount_due": 0,
		"object": "invoice_estimate",
	    "line_items": [{
			"date_from": 1438954338,
			"date_to": 1441632738,
			"unit_amount": 900,
	        "quantity": 1,
			"tax_amount": 0,
	        "object": "line_item",
			"discount_amount": 0,
			"line_amount": 1900,
	        "description": "Basic",
			"entity_type": "plan"
		}],
		"discounts": [],
		"taxes": []
	}
}}';

test($estimate);
?>