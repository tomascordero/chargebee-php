package com.chargebee;

import org.json.*;

public class APIException extends RuntimeException {

    public final JSONObject jsonObj;
    
    /**
     * Use httpStatusCode instead.
     * @deprecated
     */
    @Deprecated
    public final int httpCode;
    
    public final int httpStatusCode;
    public final String type;
    public final String code;
    public final String param;

    /**
     * Use getMessage instead.
     * @deprecated
     */
    @Deprecated
    public final String message;
    

    public APIException(int httpStatusCode,JSONObject jsonObj) throws Exception {
        super(jsonObj.getString("message"));
        this.jsonObj = jsonObj;
        this.httpCode = httpStatusCode;
        this.httpStatusCode = httpStatusCode;
        this.code = jsonObj.getString("code");
        this.type = jsonObj.optString("type");
        this.param = jsonObj.optString("param");

        this.message = jsonObj.getString("error_msg");
    }
    
    
    public boolean isParamErr() {
        return param != null;
    }

    @Override
    public String toString() {
        try {
            return jsonObj.toString(2);
        } catch (JSONException ex) {
            throw new RuntimeException(ex);
        }
    }
}
