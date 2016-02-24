/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.chargebee.internal;

/**
 *
 * @author sangeetha
 * @param <U>
 */

    
   public class TextNode<U extends ListRequestBase> extends ListRequestBase<U>{
ListRequestBase req;
    public TextNode(String paramName,String uri,ListRequestBase req ) {
        this.uri = uri;
        this.paramName = paramName;
        this.req = req;
    }
  
    public ListRequestBase contains(String value) {
        this.value = value;
        params.addFilter(paramName,"contains", value);
        return req;
    }
    
    public ListRequestBase equals(String value) {
        this.value = value;
        params.addFilter(paramName,"equals", value);
        return  req;
    }

}
 	