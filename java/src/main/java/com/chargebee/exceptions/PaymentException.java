/*
 * Copyright (c) 2011 chargebee.com
 * All Rights Reserved.
 */

package com.chargebee.exceptions;

import com.chargebee.APIException;
import org.json.*;


public class PaymentException extends APIException{

    public PaymentException(int httpStatusCode,JSONObject jsonObj) {
        super(httpStatusCode,jsonObj);
    }
    
}
