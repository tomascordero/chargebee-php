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
public class TimestampFilter<T,U extends ListRequest> {

    U req;
    String paramName;

    public TimestampFilter(String paramName, U req) {
        this.paramName = paramName;
        this.req = req;
    }

    public U before(T value) {
        req.params.addOpt(paramName + "[before]",value);
        return req;
    }

    public U after(T value) {
        req.params.addOpt(paramName + "[after]",value);
        return req;
    }
    
    public U on(T value) {
        req.params.addOpt(paramName + "[on]",value);
        return req;
    }

    public U between(T value1,T value2) {
        req.params.addOpt(paramName + "[between]", new JSONArray().put(value1).put(value2));
        return req;
    }
    
    public U isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return req;
    }
}
