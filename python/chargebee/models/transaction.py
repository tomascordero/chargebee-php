import json
from chargebee.model import Model
from chargebee import request
from chargebee import APIError

class Transaction(Model):
    class LinkedInvoice(Model):
      fields = ["invoice_id", "applied_amount", "applied_at", "invoice_date", "invoice_total", "invoice_status"]
      pass
    class LinkedCreditNote(Model):
      fields = ["cn_id", "applied_amount", "applied_at", "cn_type", "cn_reason_code", "cn_date", "cn_total", "cn_status"]
      pass

    fields = ["id", "customer_id", "subscription_id", "payment_method", "reference_number", \
    "gateway", "type", "date", "amount", "id_at_gateway", "status", "error_code", "error_text", \
    "voided_at", "payment_method_string", "reference_txn_id", "linked_invoices", "linked_credit_notes", \
    "currency_code"]


    @staticmethod
    def list(params=None, env=None, headers=None):
        return request.send('get', request.uri_path("transactions"), params, env, headers)

    @staticmethod
    def transactions_for_customer(id, params=None, env=None, headers=None):
        return request.send('get', request.uri_path("customers",id,"transactions"), params, env, headers)

    @staticmethod
    def transactions_for_subscription(id, params=None, env=None, headers=None):
        return request.send('get', request.uri_path("subscriptions",id,"transactions"), params, env, headers)

    @staticmethod
    def transactions_for_invoice(id, params=None, env=None, headers=None):
        return request.send('get', request.uri_path("invoices",id,"transactions"), params, env, headers)

    @staticmethod
    def retrieve(id, env=None, headers=None):
        return request.send('get', request.uri_path("transactions",id), None, env, headers)
