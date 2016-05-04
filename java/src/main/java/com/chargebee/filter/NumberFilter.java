/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.filter;

import org.json.JSONArray;

/**
 *
 * @author sangeetha
 * @param <T>
 * @param <U>
 */
public class NumberFilter<T,U extends ListRequest> {

    U req;
    String paramName;

    public NumberFilter(String paramName, U req) {
        this.paramName = paramName;
        this.req = req;
    }

    public U greaterThan(T value) {
        req.params.addOpt(paramName+"[gt]" , value);
        return req;
    }
    
    public U lessThan(T value) {
        req.params.addOpt(paramName+"[lt]" , value);
        return req;
    }
    
    public U greaterThanOrEquals(T value) {
        req.params.addOpt(paramName+"[gte]" , value);
        return req;
    }
    
    public U lessThanOrEquals(T value) {
        req.params.addOpt(paramName+"[lte]" , value);
        return req;
    }
    
    public U between(T val1, T val2){
        req.params.addOpt(paramName+"[between]" , new JSONArray().put(val1).put(val2));
        return req;
    }
    
    public U is(T value) {
        req.params.addOpt(paramName+"[is]" , value);
        return req;
    }
    
    public U isNot(T value) {
        req.params.addOpt(paramName+"[is_not]" , value);
        return req;
    }
    
    public U isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return req;
    }

}
