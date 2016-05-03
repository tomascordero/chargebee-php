/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.filter;

import com.chargebee.internal.HttpUtil;
import java.util.Arrays;
import org.json.JSONArray;

/**
 *
 * @author sangeetha
 * @param <T>
 */
public class EnumFilter<T> extends ListRequest {

    ListRequest req;
    String paramName;

    public EnumFilter(String paramName, String uri, ListRequest req) {
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
     
    public ListRequest in(T... value) {
        req.params.addOpt(paramName + "[in]",new JSONArray(Arrays.asList(value)));
        return req;
    } 

    public ListRequest notIn(T... value) {
        req.params.addOpt(paramName + "[not_in]",new JSONArray(Arrays.asList(value)));
        return req;
    }
    
     public ListRequest isPresent(T value) {
        req.params.addOpt(paramName + "[is_present]", value);
        return req;
    }

}
