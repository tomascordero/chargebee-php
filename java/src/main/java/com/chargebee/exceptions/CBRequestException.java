/*
 * Copyright (c) 2011 chargebee.com
 * All Rights Reserved.
 */

package com.chargebee.exceptions;

import com.chargebee.APIException;
import org.json.*;


public class CBRequestException extends APIException{

    public CBRequestException(int httpStatusCode,JSONObject jsonObj) {
        super(httpStatusCode,jsonObj);
    }
    
}
