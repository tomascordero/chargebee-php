/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.chargebee.filter;

import java.util.Arrays;
import org.json.JSONArray;

/**
 *
 * @author sangeetha
 * @param <T>
 */
public class EnumeratedStringFilter<T> extends StringFilter  {

    public EnumeratedStringFilter(String paramName, String uri, ListRequest req) {
        super(paramName, uri, req);
    }

    public ListRequest in(T... value) {
        req.params.addOpt(paramName + "[in]", new JSONArray(Arrays.asList(value)));
        return req;
    }

    public ListRequest notIn(T... value) {
        req.params.addOpt(paramName + "[not_in]", new JSONArray(Arrays.asList(value)));
        return req;
    }

}
