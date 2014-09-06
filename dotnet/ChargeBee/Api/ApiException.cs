using System;
using System.Net;
using System.Runtime.Serialization;

namespace ChargeBee.Api
{
    public class ApiException : ApplicationException
    {
        public ApiException(SerializationInfo info, StreamingContext context)
        {
            if (info != null)
            {
                foreach (var item in info)
                {
                    switch (item.Name)
                    {
                        case "code":
                            Code = item.Value.ToString();
                            break;
                        case "param":
                            Param = item.Value.ToString();
                            Parameter = Param;
                            break;
                        case "msg":
                            Msg = item.Value.ToString();
                            ApiMessage = Msg;
                            break;
                        case "type":
                            Type = item.Value.ToString();
                            break;
                        case "error_code":
                            ApiCode = item.Value.ToString();
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        public override void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            base.GetObjectData(info, context);

            if (info != null)
            {
                info.AddValue("type", Type);
                info.AddValue("code", Code);
                info.AddValue("param", Param);
                info.AddValue("msg", Msg);
                info.AddValue("error_code", ApiCode);
            }
        }

        public HttpStatusCode HttpStatusCode { get; set; }

        public string Code { get; set; }

        public string Param { get; set; }

        public string Msg { get; set; }

        public string Type { get; set; }

        [System.Obsolete("Use HttpStatusCode")]
        public HttpStatusCode HttpCode { get; set; }

        [System.Obsolete("Use Code")]
        public string ApiCode { get; set; }

        [System.Obsolete("Use Param")]
        public string Parameter { get; set; }

        [System.Obsolete("Use Msg")]
        public string ApiMessage { get; set; }

        public override string Message
        {
            get
            {
                return ApiMessage;
            }
        }
    }
}
