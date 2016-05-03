/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.filter;

import com.chargebee.internal.HttpUtil;
import java.util.ArrayList;
import java.util.Arrays;
import org.json.JSONArray;

/**
 *
 * @author sangeetha
 */
public class TimestampFilter<T> extends ListRequest {

    ListRequest req;
    String paramName;

    public TimestampFilter(String paramName, String uri, ListRequest req) {
        super(uri);
        this.paramName = paramName;
        this.req = req;
    }

    public ListRequest before(T value) {
        req.params.addOpt(paramName + "[before]",value);
        return req;
    }

    public ListRequest after(T value) {
        req.params.addOpt(paramName + "[after]",value);
        return req;
    }
    
    public ListRequest on(T value) {
        req.params.addOpt(paramName + "[on]",value);
        return req;
    }

    public ListRequest between(T value1,T value2) {
        req.params.addOpt(paramName + "[between]", new JSONArray().put(value1).put(value2));
        return req;
    }
    
    public ListRequest isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return req;
    }
}
