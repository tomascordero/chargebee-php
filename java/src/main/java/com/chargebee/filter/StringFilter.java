/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.filter;

import com.chargebee.internal.HttpUtil;

/**
 *
 * @author sangeetha
 */
public class StringFilter<T> extends ListRequest {

    ListRequest req;
    String paramName;

    public StringFilter(String paramName, String uri, ListRequest req) {
        super(uri);
        this.paramName = paramName;
        this.req = req;
    }

    public ListRequest is(T value) {
        req.params.addOpt(paramName + "[is]",value);
        return req;
    }

    public ListRequest isNot(T value) {
        req.params.addOpt(paramName + "[is_not]",value);
        return req;
    }

    public ListRequest startsWith(T value) {
        req.params.addOpt(paramName + "[starts_with]", value);
        return req;
    }
    
    public ListRequest isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return req;
    }
}
