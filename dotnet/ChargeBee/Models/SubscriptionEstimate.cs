using System;
using System.IO;
using System.ComponentModel;
using System.Collections.Generic;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

using ChargeBee.Internal;
using ChargeBee.Api;
using ChargeBee.Models.Enums;

namespace ChargeBee.Models
{

    public class SubscriptionEstimate : Resource 
    {
    

        #region Methods
        #endregion
        
        #region Properties
        public string Id 
        {
            get { return GetValue<string>("id", true); }
        }
        public StatusEnum? Status 
        {
            get { return GetEnum<StatusEnum>("status", false); }
        }
        public DateTime? NextBillingAt 
        {
            get { return GetDateTime("next_billing_at", false); }
        }
        
        #endregion
        


        #region Subclasses

        #endregion
    }
}
