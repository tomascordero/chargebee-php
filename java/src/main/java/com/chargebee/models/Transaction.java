package com.chargebee.models;

import com.chargebee.*;
import com.chargebee.internal.*;
import com.chargebee.internal.HttpUtil.Method;
import com.chargebee.models.enums.*;
import org.json.*;
import java.io.*;
import java.sql.Timestamp;
import java.util.*;

public class Transaction extends Resource<Transaction> {

    public enum PaymentMethod {
        CARD,
        CASH,
        CHECK,
        BANK_TRANSFER,
        OTHER,
        _UNKNOWN; /*Indicates unexpected value for this enum. You can get this when there is a
        java-client version incompatibility. We suggest you to upgrade to the latest version */
    }

    public enum Type {
        AUTHORIZATION,
        PAYMENT,
        REFUND,
        _UNKNOWN; /*Indicates unexpected value for this enum. You can get this when there is a
        java-client version incompatibility. We suggest you to upgrade to the latest version */
    }

    public enum Status {
        SUCCESS,
        VOIDED,
        FAILURE,
        TIMEOUT,
        NEEDS_ATTENTION,
        _UNKNOWN; /*Indicates unexpected value for this enum. You can get this when there is a
        java-client version incompatibility. We suggest you to upgrade to the latest version */
    }

    public static class LinkedInvoice extends Resource<LinkedInvoice> {
        public LinkedInvoice(JSONObject jsonObj) {
            super(jsonObj);
        }

        public String invoiceId() {
            return reqString("invoice_id");
        }

        public Integer appliedAmount() {
            return reqInteger("applied_amount");
        }

        public Timestamp invoiceDate() {
            return optTimestamp("invoice_date");
        }

        public Integer invoiceAmount() {
            return optInteger("invoice_amount");
        }

    }

    //Constructors
    //============

    public Transaction(String jsonStr) {
        super(jsonStr);
    }

    public Transaction(JSONObject jsonObj) {
        super(jsonObj);
    }

    // Fields
    //=======

    public String id() {
        return reqString("id");
    }

    public String subscriptionId() {
        return optString("subscription_id");
    }

    public PaymentMethod paymentMethod() {
        return reqEnum("payment_method", PaymentMethod.class);
    }

    public String referenceNumber() {
        return optString("reference_number");
    }

    public Gateway gateway() {
        return reqEnum("gateway", Gateway.class);
    }

    public String description() {
        return optString("description");
    }

    public Type type() {
        return reqEnum("type", Type.class);
    }

    public Timestamp date() {
        return optTimestamp("date");
    }

    public Integer amount() {
        return optInteger("amount");
    }

    public String idAtGateway() {
        return optString("id_at_gateway");
    }

    public Status status() {
        return optEnum("status", Status.class);
    }

    public String errorCode() {
        return optString("error_code");
    }

    public String errorText() {
        return optString("error_text");
    }

    public Timestamp voidedAt() {
        return optTimestamp("voided_at");
    }

    public String voidDescription() {
        return optString("void_description");
    }

    public String maskedCardNumber() {
        return reqString("masked_card_number");
    }

    public String refundedTxnId() {
        return optString("refunded_txn_id");
    }

    public List<Transaction.LinkedInvoice> linkedInvoices() {
        return optList("linked_invoices", Transaction.LinkedInvoice.class);
    }

    // Operations
    //===========

    public static ListRequest list() throws IOException {
        String uri = uri("transactions");
        return new ListRequest(uri);
    }

    public static ListRequest transactionsForSubscription(String id) throws IOException {
        String uri = uri("subscriptions", nullCheck(id), "transactions");
        return new ListRequest(uri);
    }

    public static ListRequest transactionsForInvoice(String id) throws IOException {
        String uri = uri("invoices", nullCheck(id), "transactions");
        return new ListRequest(uri);
    }

    public static Request retrieve(String id) throws IOException {
        String uri = uri("transactions", nullCheck(id));
        return new Request(Method.GET, uri);
    }

    public static RecordPaymentRequest recordPayment(String id) throws IOException {
        String uri = uri("invoices", nullCheck(id), "record_payment");
        return new RecordPaymentRequest(Method.POST, uri);
    }

    public static RefundRequest refund(String id) throws IOException {
        String uri = uri("transactions", nullCheck(id), "refund");
        return new RefundRequest(Method.POST, uri);
    }


    // Operation Request Classes
    //==========================

    public static class RecordPaymentRequest extends Request<RecordPaymentRequest> {

        private RecordPaymentRequest(Method httpMeth, String uri) {
            super(httpMeth, uri);
        }
    
        public RecordPaymentRequest paymentMethod(PaymentMethod paymentMethod) {
            params.add("payment_method", paymentMethod);
            return this;
        }


        public RecordPaymentRequest paidAt(Timestamp paidAt) {
            params.add("paid_at", paidAt);
            return this;
        }


        public RecordPaymentRequest referenceNumber(String referenceNumber) {
            params.addOpt("reference_number", referenceNumber);
            return this;
        }


        public RecordPaymentRequest memo(String memo) {
            params.addOpt("memo", memo);
            return this;
        }


        @Override
        public Params params() {
            return params;
        }
    }

    public static class RefundRequest extends Request<RefundRequest> {

        private RefundRequest(Method httpMeth, String uri) {
            super(httpMeth, uri);
        }
    
        public RefundRequest refundAmount(Integer refundAmount) {
            params.addOpt("refund_amount", refundAmount);
            return this;
        }


        public RefundRequest memo(String memo) {
            params.addOpt("memo", memo);
            return this;
        }


        @Override
        public Params params() {
            return params;
        }
    }

}