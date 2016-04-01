/*
 * Copyright (c) 2016 ChargeBee Inc
 * All Rights Reserved.
 */

package com.chargebee;

import com.chargebee.models.Event;
import com.chargebee.models.enums.Gateway;

/**
 *
 * @author saravana
 */
public class Test {
    public static void main(String[] args) {
        String event = "{\n" +
"    'id': 'ev___dev__KyVqhSPh5pNjDA',\n" +
"    'occurred_at': 1459485730,\n" +
"    'source': 'admin_console',\n" +
"    'user': 'rr@mannar.com',\n" +
"    'object': 'event',\n" +
"    'api_version': 'v2',\n" +
"    'content': {\n" +
"        'subscription': {\n" +
"            'id': '__dev__KyVqhSPh5pNOI4',\n" +
"            'plan_id': 'plan',\n" +
"            'plan_quantity': 1,\n" +
"            'status': 'active',\n" +
"            'current_term_start': 1459485727,\n" +
"            'current_term_end': 1462077727,\n" +
"            'created_at': 1459485727,\n" +
"            'started_at': 1459485727,\n" +
"            'activated_at': 1459485727,\n" +
"            'has_scheduled_changes': false,\n" +
"            'object': 'subscription',\n" +
"            'due_invoices_count': 1,\n" +
"            'due_since': 1459485727,\n" +
"            'total_dues': 1000\n" +
"        },\n" +
"        'customer': {\n" +
"            'id': '__dev__KyVqhSPh5pNOI4',\n" +
"            'auto_collection': 'off',\n" +
"            'allow_direct_debit': false,\n" +
"            'created_at': 1459485727,\n" +
"            'taxability': 'taxable',\n" +
"            'object': 'customer',\n" +
"            'card_status': 'no_card',\n" +
"            'promotional_credits': 0,\n" +
"            'refundable_credits': 0,\n" +
"            'excess_payments': 0\n" +
"        },\n" +
"        'invoice': {\n" +
"            'id': '1',\n" +
"            'customer_id': '__dev__KyVqhSPh5pNOI4',\n" +
"            'subscription_id': '__dev__KyVqhSPh5pNOI4',\n" +
"            'recurring': true,\n" +
"            'status': 'payment_due',\n" +
"            'price_type': 'tax_exclusive',\n" +
"            'date': 1459485727,\n" +
"            'total': 1000,\n" +
"            'amount_paid': 0,\n" +
"            'amount_adjusted': 0,\n" +
"            'write_off_amount': 0,\n" +
"            'credits_applied': 0,\n" +
"            'amount_due': 1000,\n" +
"            'object': 'invoice',\n" +
"            'first_invoice': true,\n" +
"            'currency_code': 'USD',\n" +
"            'tax': 0,\n" +
"            'line_items': [{\n" +
"                'date_from': 1459485727,\n" +
"                'date_to': 1462077727,\n" +
"                'unit_amount': 1000,\n" +
"                'quantity': 1,\n" +
"                'is_taxed': false,\n" +
"                'tax_amount': 0,\n" +
"                'object': 'line_item',\n" +
"                'amount': 1000,\n" +
"                'description': 'plan',\n" +
"                'entity_type': 'plan',\n" +
"                'entity_id': 'plan',\n" +
"                'discount_amount': 0,\n" +
"                'item_level_discount_amount': 0\n" +
"            }],\n" +
"            'sub_total': 1000,\n" +
"            'linked_payments': [],\n" +
"            'applied_credits': [],\n" +
"            'adjustment_credit_notes': [],\n" +
"            'issued_credit_notes': [],\n" +
"            'linked_orders': []\n" +
"        }\n" +
"    },\n" +
"    'event_type': 'subscription_created',\n" +
"    'webhook_status': 'scheduled'\n" +
"}";
        Environment.configure(event, event);
        Event event1 = new Event(event);
       
    }
    
}
