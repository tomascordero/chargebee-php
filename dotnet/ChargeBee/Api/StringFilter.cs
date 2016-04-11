using System.Collections.Generic;

namespace ChargeBee.Api
{
    public class StringFilter<T> extends ListRequest
    {
    	ListRequest req;
    	string paramName;

    	public StringFilter(string pName, string uri, ListRequest request) {
	        super(uri);
	        paramName = pName;
	        req = request;
    	}

    	public ListRequest Is(T value) {
	        req.m_params.AddOpt(paramName + "[is]",value);
	        return req;
    	}

    	public ListRequest IsNot(T value) {
	        req.m_params.AddOpt(paramName + "[is_not]",value);
	        return req;
    	}

	    public ListRequest StartsWith(T value) {
	        req.m_params.AddOpt(paramName + "[starts_with]", value);
	        return req;
	    }
	}
}
