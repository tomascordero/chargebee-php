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

    public class Coupon : Resource 
    {
    

        #region Methods
        public static CreateRequest Create()
        {
            string url = ApiUtil.BuildUrl("coupons");
            return new CreateRequest(url, HttpMethod.POST);
        }
        public static ListRequest List()
        {
            string url = ApiUtil.BuildUrl("coupons");
            return new ListRequest(url);
        }
        public static EntityRequest Retrieve(string id)
        {
            string url = ApiUtil.BuildUrl("coupons", CheckNull(id));
            return new EntityRequest(url, HttpMethod.GET);
        }
        #endregion
        
        #region Properties
        public string Id 
        {
            get { return GetValue<string>("id", true); }
        }
        public string Name 
        {
            get { return GetValue<string>("name", true); }
        }
        public string InvoiceName 
        {
            get { return GetValue<string>("invoice_name", false); }
        }
        public DiscountTypeEnum DiscountType 
        {
            get { return GetEnum<DiscountTypeEnum>("discount_type", true); }
        }
        public double? DiscountPercentage 
        {
            get { return GetValue<double?>("discount_percentage", false); }
        }
        public int? DiscountAmount 
        {
            get { return GetValue<int?>("discount_amount", false); }
        }
        public int? DiscountQuantity 
        {
            get { return GetValue<int?>("discount_quantity", false); }
        }
        public DurationTypeEnum DurationType 
        {
            get { return GetEnum<DurationTypeEnum>("duration_type", true); }
        }
        public int? DurationMonth 
        {
            get { return GetValue<int?>("duration_month", false); }
        }
        public DateTime? ValidTill 
        {
            get { return GetDateTime("valid_till", false); }
        }
        public int? MaxRedemptions 
        {
            get { return GetValue<int?>("max_redemptions", false); }
        }
        public StatusEnum? Status 
        {
            get { return GetEnum<StatusEnum>("status", false); }
        }
        public int? Redemptions 
        {
            get { return GetValue<int?>("redemptions", false); }
        }
        [Obsolete]
        public ApplyDiscountOnEnum ApplyDiscountOn 
        {
            get { return GetEnum<ApplyDiscountOnEnum>("apply_discount_on", true); }
        }
        public ApplyOnEnum ApplyOn 
        {
            get { return GetEnum<ApplyOnEnum>("apply_on", true); }
        }
        public ApplicablePlansEnum ApplicablePlans 
        {
            get { return GetEnum<ApplicablePlansEnum>("applicable_plans", true); }
        }
        public ApplicableAddonsEnum ApplicableAddons 
        {
            get { return GetEnum<ApplicableAddonsEnum>("applicable_addons", true); }
        }
        public DateTime CreatedAt 
        {
            get { return (DateTime)GetDateTime("created_at", true); }
        }
        public DateTime? ArchivedAt 
        {
            get { return GetDateTime("archived_at", false); }
        }
        public List<string> PlanIds 
        {
            get { return GetList<string>("plan_ids"); }
        }
        public List<string> AddonIds 
        {
            get { return GetList<string>("addon_ids"); }
        }
        
        #endregion
        
        #region Requests
        public class CreateRequest : EntityRequest 
        {
            public CreateRequest(string url, HttpMethod method) 
                    : base(url, method)
            {
            }

            public CreateRequest Name(string name) 
            {
                m_params.Add("name", name);
                return this;
            }
            public CreateRequest Id(string id) 
            {
                m_params.Add("id", id);
                return this;
            }
            public CreateRequest InvoiceName(string invoiceName) 
            {
                m_params.AddOpt("invoice_name", invoiceName);
                return this;
            }
            public CreateRequest DiscountType(DiscountTypeEnum discountType) 
            {
                m_params.Add("discount_type", discountType);
                return this;
            }
            public CreateRequest DiscountAmount(int discountAmount) 
            {
                m_params.AddOpt("discount_amount", discountAmount);
                return this;
            }
            public CreateRequest DiscountPercentage(double discountPercentage) 
            {
                m_params.AddOpt("discount_percentage", discountPercentage);
                return this;
            }
            public CreateRequest DiscountQuantity(int discountQuantity) 
            {
                m_params.AddOpt("discount_quantity", discountQuantity);
                return this;
            }
            public CreateRequest ApplyOn(ApplyOnEnum applyOn) 
            {
                m_params.Add("apply_on", applyOn);
                return this;
            }
            public CreateRequest ApplicablePlans(ApplicablePlansEnum applicablePlans) 
            {
                m_params.AddOpt("applicable_plans", applicablePlans);
                return this;
            }
            public CreateRequest ApplicableAddons(ApplicableAddonsEnum applicableAddons) 
            {
                m_params.AddOpt("applicable_addons", applicableAddons);
                return this;
            }
            public CreateRequest DurationType(DurationTypeEnum durationType) 
            {
                m_params.Add("duration_type", durationType);
                return this;
            }
            public CreateRequest DurationMonth(int durationMonth) 
            {
                m_params.AddOpt("duration_month", durationMonth);
                return this;
            }
            public CreateRequest ValidTill(long validTill) 
            {
                m_params.AddOpt("valid_till", validTill);
                return this;
            }
            public CreateRequest MaxRedemptions(int maxRedemptions) 
            {
                m_params.AddOpt("max_redemptions", maxRedemptions);
                return this;
            }
            public CreateRequest PlanId(int index, string planId) 
            {
                m_params.AddOpt("plans[id][" + index + "]", planId);
                return this;
            }
            public CreateRequest AddonId(int index, string addonId) 
            {
                m_params.AddOpt("addons[id][" + index + "]", addonId);
                return this;
            }
        }
        #endregion

        public enum DiscountTypeEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("fixed_amount")]
            FixedAmount,
            [Description("percentage")]
            Percentage,
            [Description("offer_quantity")]
            OfferQuantity,

        }
        public enum DurationTypeEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("one_time")]
            OneTime,
            [Description("forever")]
            Forever,
            [Description("limited_period")]
            LimitedPeriod,

        }
        public enum StatusEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("active")]
            Active,
            [Description("expired")]
            Expired,
            [Description("archived")]
            Archived,

        }
        public enum ApplyDiscountOnEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("plans")]
            Plans,
            [Description("plans_and_addons")]
            PlansAndAddons,
            [Description("plans_with_quantity")]
            PlansWithQuantity,
            [Description("not_applicable")]
            NotApplicable,

        }
        public enum ApplyOnEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("invoice_amount")]
            InvoiceAmount,
            [Description("specified_items_total")]
            SpecifiedItemsTotal,
            [Description("each_specified_item")]
            EachSpecifiedItem,
            [Description("each_unit_of_specified_items")]
            EachUnitOfSpecifiedItems,

        }
        public enum ApplicablePlansEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("none")]
            None,
            [Description("all")]
            All,
            [Description("specific")]
            Specific,

        }
        public enum ApplicableAddonsEnum
        {

            UnKnown, /*Indicates unexpected value for this enum. You can get this when there is a
            dotnet-client version incompatibility. We suggest you to upgrade to the latest version */
            [Description("none")]
            None,
            [Description("all")]
            All,
            [Description("specific")]
            Specific,

        }

        #region Subclasses

        #endregion
    }
}
