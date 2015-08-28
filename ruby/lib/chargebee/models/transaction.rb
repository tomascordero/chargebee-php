module ChargeBee
  class Transaction < Model

    class LinkedInvoice < Model
      attr_accessor :invoice_id, :applied_amount, :applied_at, :invoice_date, :invoice_total, :invoice_status
    end

    class LinkedCreditNote < Model
      attr_accessor :cn_id, :applied_amount, :applied_at, :cn_type, :cn_reason_code, :cn_date, :cn_total, :cn_status
    end

  attr_accessor :id, :customer_id, :subscription_id, :payment_method, :reference_number, :gateway,
  :type, :date, :amount, :id_at_gateway, :status, :error_code, :error_text, :voided_at, :payment_method_string,
  :reference_txn_id, :linked_invoices, :linked_credit_notes, :currency_code

  # OPERATIONS
  #-----------

  def self.list(params={}, env=nil, headers={})
    Request.send('get', uri_path("transactions"), params, env, headers)
  end

  def self.transactions_for_customer(id, params={}, env=nil, headers={})
    Request.send('get', uri_path("customers",id.to_s,"transactions"), params, env, headers)
  end

  def self.transactions_for_subscription(id, params={}, env=nil, headers={})
    Request.send('get', uri_path("subscriptions",id.to_s,"transactions"), params, env, headers)
  end

  def self.transactions_for_invoice(id, params={}, env=nil, headers={})
    Request.send('get', uri_path("invoices",id.to_s,"transactions"), params, env, headers)
  end

  def self.retrieve(id, env=nil, headers={})
    Request.send('get', uri_path("transactions",id.to_s), {}, env, headers)
  end

  end # ~Transaction
end # ~ChargeBee