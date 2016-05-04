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
 * @param <U>
 */
public class EnumeratedNumberFilter<T,U extends ListRequest> extends NumberFilter<T, U>{

    public EnumeratedNumberFilter(String paramName, U req) {
        super(paramName, req);
    }

    public U in(T... value) {
        req.params.addOpt(paramName + "[in]", new JSONArray(Arrays.asList(value)));
        return req;
    }

    public U notIn(T... value) {
        req.params.addOpt(paramName + "[not_in]", new JSONArray(Arrays.asList(value)));
        return req;
    }
    
}
