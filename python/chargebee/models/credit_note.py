import json
from chargebee.model import Model
from chargebee import request
from chargebee import APIError

class CreditNote(Model):
    class LineItem(Model):
      fields = ["date_from", "date_to", "unit_amount", "quantity", "is_taxed", "tax_amount", "tax_rate", "discount_amount", "line_amount", "description", "entity_type", "entity_id"]
      pass
    class Discount(Model):
      fields = ["amount", "description", "entity_type", "entity_id"]
      pass
    class Tax(Model):
      fields = ["amount", "description"]
      pass
    class LinkedTransaction(Model):
      fields = ["txn_id", "applied_amount", "applied_at", "txn_type", "txn_status", "txn_date", "txn_amount"]
      pass
    class Allocation(Model):
      fields = ["invoice_id", "applied_amount", "applied_at", "invoice_date", "invoice_status"]
      pass

    fields = ["id", "customer_id", "subscription_id", "reference_invoice_id", "type", "reason_code", \
    "status", "vat_number", "date", "total", "credits_allocated", "refunds_made", "remaining_credits", \
    "paid_at", "sub_total", "line_items", "discounts", "taxes", "linked_transactions", "allocations"]


    @staticmethod
    def retrieve(id, env=None, headers=None):
        return request.send('get', request.uri_path("credit_notes",id), None, env, headers)

    @staticmethod
    def list(params=None, env=None, headers=None):
        return request.send('get', request.uri_path("credit_notes"), params, env, headers)

    @staticmethod
    def credit_notes_for_customer(id, params=None, env=None, headers=None):
        return request.send('get', request.uri_path("customers",id,"credit_notes"), params, env, headers)
