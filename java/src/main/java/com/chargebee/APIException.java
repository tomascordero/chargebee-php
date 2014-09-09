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
    public final String msg;
    public final String param;
    

    public APIException(int httpStatusCode,JSONObject jsonObj) {
        super(constructMessage(jsonObj));
        this.jsonObj = jsonObj;
        this.httpCode = httpStatusCode;
        this.httpStatusCode = httpStatusCode;
        this.msg = jsonObj.optString("msg","");
        this.code = jsonObj.optString("code","invalid_request");
        this.type = jsonObj.optString("type","invalid_request");
        this.param = jsonObj.optString("param");
    }

    private static String constructMessage(JSONObject jsonObj){
        String message = jsonObj.optString("msg","");
        String param = jsonObj.optString("param");
        if(param != null){
             message = param + " : " + message;
        }
        return message;
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
