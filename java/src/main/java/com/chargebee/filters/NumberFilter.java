package com.chargebee.filters;

import com.chargebee.internal.ListRequest;

/**
 *
 * @author sangeetha
 * @param <T>
 * @param <U>
 */
public class NumberFilter<T,U extends ListRequest> {

    private U req;
    private String paramName;
    private boolean supportsPresenceOperator;

    public NumberFilter(String paramName, U req) {
        this.paramName = paramName;
        this.req = req;
    }
    
    public NumberFilter<T,U> supportsPresenceOperator(boolean supportsPresenceOperator) {
        this.supportsPresenceOperator = supportsPresenceOperator;
        return this;
    }
    
    public U greaterThan(T value) {
        req.params().addOpt(paramName+"[gt]" , value);
        return req;
    }
    
    public U lessThan(T value) {
        req.params().addOpt(paramName+"[lt]" , value);
        return req;
    }
    
    public U greaterThanOrEquals(T value) {
        req.params().addOpt(paramName+"[gte]" , value);
        return req;
    }
    
    public U lessThanOrEquals(T value) {
        req.params().addOpt(paramName+"[lte]" , value);
        return req;
    }
    
    public U between(T val1, T val2){
        req.params().addOpt(paramName + "[between]", (T[])new Object[]{val1, val2});
        return req;
    }
    
    public U is(T value) {
        req.params().addOpt(paramName+"[is]" , value);
        return req;
    }
    
    public U isNot(T value) {
        req.params().addOpt(paramName+"[is_not]" , value);
        return req;
    }
    
    public U isPresent(boolean value) {
        if(!supportsPresenceOperator) {
            throw new UnsupportedOperationException("operator '[is_present]' is not supported for this filter-parameter");
        }
        
        req.params().addOpt(paramName + "[is_present]", value);
        return req;
    }

}
