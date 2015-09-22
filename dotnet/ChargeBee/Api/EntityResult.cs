using System.Net;
using ChargeBee.Internal;
using System.IO;
using System;

namespace ChargeBee.Api
{
    public class EntityResult : ResultBase
    {

        public EntityResult(HttpStatusCode statusCode, string json)
            : base(json)
        {
            StatusCode = statusCode;
        }

        public HttpStatusCode StatusCode { get; private set; }

    


	public static void Main(string[] args)
	{
		string fileName="../files/updSub.json";
		string json = "";

		using (var reader = new StreamReader(fileName))
		{
			string line;
			while ((line = reader.ReadLine()) != null)
			{
				json += line; 
			}
		}


			EntityResult res = new EntityResult(HttpStatusCode.BadGateway, json);
			Console.Write (res.CreditNotes);
		}
	}

}
