package com.chargebee.filters;

import com.chargebee.internal.ListRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import org.json.JSONArray;

/**
 *
 * @author sangeetha
 * @param <T>
 * @param <U>
 */
public class TimestampFilter<U extends ListRequest> {

    private U req;
    private String paramName;
    private boolean supportsPresenceOperator;

    public TimestampFilter(String paramName, U req) {
        this.paramName = paramName;
        this.req = req;
    }

    public TimestampFilter<U> supportsPresenceOperator(boolean supportsPresenceOperator) {
        this.supportsPresenceOperator = supportsPresenceOperator;
        return this;
    }

    public U on(Timestamp value) {
        req.params().addOpt(paramName + "[on]", value);
        return req;
    }

    public U before(Timestamp value) {
        req.params().addOpt(paramName + "[before]", value);
        return req;
    }

    public U after(Timestamp value) {
        req.params().addOpt(paramName + "[after]", value);
        return req;
    }

    public U between(Timestamp value1, Timestamp value2) {
        JSONArray jArr = serialize(new ArrayList<Timestamp>(Arrays.asList(value1,value2)));
        req.params().addOpt(paramName + "[between]", jArr);
        return req;
    }

    public U isPresent(boolean value) {
        if (!supportsPresenceOperator) {
            throw new UnsupportedOperationException("operator '[is_present]' is not supported for this filter-parameter");
        }
        req.params().addOpt(paramName + "[is_present]", value);
        return req;
    }
    
    private JSONArray serialize(ArrayList<Timestamp> list){
        JSONArray jArr = new JSONArray();
        for(Timestamp timestamp : list){
            jArr.put(timestamp.getTime() / 1000);
        }
        return jArr;
    }
}
