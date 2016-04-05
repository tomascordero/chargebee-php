/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.internal;

import org.json.JSONArray;

/**
 *
 * @author sangeetha
 * @param <T>
 */
public class NumberFilter<T> extends ListRequest {

    ListRequest req;
    String uri;
    String paramName;

    public NumberFilter(String paramName, String uri,ListRequest req) {
        super(uri);
        this.uri = uri;
        this.paramName = paramName;
        this.req = req;
    }

    public ListRequest greaterThan(T value) {
        req.params.addOpt(paramName+"[gt]" , value);
        return req;
    }
    
    public ListRequest lessThan(T value) {
        req.params.addOpt(paramName+"[lt]" , value);
        return req;
    }
    
    public ListRequest greaterThanOrEquals(T value) {
        req.params.addOpt(paramName+"[gte]" , value);
        return req;
    }
    
    public ListRequest lessThanOrEquals(T value) {
        req.params.addOpt(paramName+"[lte]" , value);
        return req;
    }
    
    public ListRequest between(T val1, T val2){
        req.params.addOpt(paramName+"[between]" , new JSONArray().put(val1).put(val2));
        return req;
    }
    
    public ListRequest is(T value) {
        req.params.addOpt(paramName+"[is]" , value);
        return req;
    }
    
    public ListRequest isNot(T value) {
        req.params.addOpt(paramName+"[is_not]" , value);
        return req;
    }

}
