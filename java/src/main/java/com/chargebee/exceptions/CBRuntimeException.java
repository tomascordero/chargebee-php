/*
 * Copyright (c) 2011 chargebee.com
 * All Rights Reserved.
 */

package com.chargebee.exceptions;

import com.chargebee.APIException;
import org.json.*;


public class CBRuntimeException extends APIException{

    public CBRuntimeException(int httpStatusCode,JSONObject jsonObj) {
        super(httpStatusCode,jsonObj);
    }

}
