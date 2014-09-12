using System;
using System.Net;
using System.Runtime.Serialization;
using System.Collections.Generic;

namespace ChargeBee.Api
{
    public class ApiException : ApplicationException
    {

		private string ErrorType = "";
		private string ErrorParam = "";

		public ApiException (HttpStatusCode httpStatusCode, Dictionary<string, string> errorResp)
			: base (errorResp ["message"])
        {
			this.HttpStatusCode = httpStatusCode;
			errorResp.TryGetValue ("type", out ErrorType);
			this.Code = errorResp ["api_error_code"];

			//Deprecated fields.
			this.ApiCode = errorResp ["error_code"];
			this.ApiMessage = errorResp ["error_msg"];

			errorResp.TryGetValue("param", out ErrorParam);
        }

        public HttpStatusCode HttpStatusCode { get; set; }

		public string Type { 
			get {
				return this.ErrorType;
			}
		}

        public string Code { get; set; }

        public string Param { 
			get {
				return this.ErrorParam;
			}
		}

        [System.Obsolete("Use HttpStatusCode")]
        public HttpStatusCode HttpCode { 
			get {
				return HttpStatusCode;
			}
		}

        [System.Obsolete("Use Code")]
		public string ApiCode { get; set; }

        [System.Obsolete("Use Param")]
		public string Parameter { 
			get { 
				return Param;
			} 
		}

        [System.Obsolete("Use Messsge")]
        public string ApiMessage { get; set; }

    }
}
