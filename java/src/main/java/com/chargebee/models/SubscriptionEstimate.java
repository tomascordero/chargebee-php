package com.chargebee.models;

import com.chargebee.*;
import com.chargebee.internal.*;
import com.chargebee.internal.HttpUtil.Method;
import com.chargebee.models.enums.*;
import org.json.*;
import java.io.*;
import java.sql.Timestamp;
import java.util.*;

public class SubscriptionEstimate extends Resource<SubscriptionEstimate> {

    //Constructors
    //============

    public SubscriptionEstimate(String jsonStr) {
        super(jsonStr);
    }

    public SubscriptionEstimate(JSONObject jsonObj) {
        super(jsonObj);
    }

    // Fields
    //=======

    public String id() {
        return reqString("id");
    }

    public Status status() {
        return optEnum("status", Status.class);
    }

    public Timestamp nextBillingAt() {
        return optTimestamp("next_billing_at");
    }

    // Operations
    //===========


}
