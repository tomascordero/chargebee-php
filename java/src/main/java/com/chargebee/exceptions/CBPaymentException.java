/*
 * Copyright (c) 2011 chargebee.com
 * All Rights Reserved.
 */

package com.chargebee.exceptions;

import com.chargebee.APIException;
import org.json.*;


public class CBPaymentException extends APIException{

    public CBPaymentException(int httpStatusCode,JSONObject jsonObj) {
        super(httpStatusCode,jsonObj);
    }
    
}
