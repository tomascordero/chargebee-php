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
 * @param <T>
 */
public class BooleanFilter<T> extends ListRequest {

    ListRequest req;
    String paramName;

    public BooleanFilter(String paramName, String uri, ListRequest req) {
        super(uri);
        this.paramName = paramName;
        this.req = req;
    }

    public ListRequest is(T value) {
        req.params.addOpt(paramName + "[is]", value);
        return (ListRequest) req;
    }
    
    public ListRequest isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return (ListRequest) req;
    }
}
