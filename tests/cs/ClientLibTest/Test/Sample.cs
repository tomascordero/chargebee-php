using System;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Net;
using System.Web;
using System.Reflection;

using ChargeBee.Api;
using ChargeBee.Models;
using ChargeBee.Models.Enums;

using Newtonsoft.Json;

namespace Examples
{

	public class Sample
	{

		public void Configure()
		{
			ApiConfig.Proto = "http";
			ApiConfig.DomainSuffix = "chargebee.com";
			ApiConfig.Configure("vaibhav-1-test", "test_5edlkZPTuthqWqNFEpJePjvtpcuTAIpBo");
		}

		public void TestSerializeEvent()
		{
			Event e = new Event(@"{
						    'id': 'ev_8avWjOLGCcwL4',
						    'occurred_at': 1317407414,
						    'source': 'system',
						    'object': 'event',
						    'content': {
						        'customer': {
						            'id': '8avWjOLGCcfp2',
						            'first_name': 'Benjamin',
						            'last_name': 'Ross',
						            'email': 'Benjamin@test.com',
						            'auto_collection': 'on',
						            'created_at': 1317407413,
						            'object': 'customer',
						            'card_status': 'valid'
						        },
						        'card': {
						            'customer_id': '8avWjOLGCcfp2',
						            'status': 'valid',
						            'gateway': 'chargebee',
						            'iin': '411111',
						            'last4': '1111',
						            'card_type': 'visa',
						            'expiry_month': 1,
						            'expiry_year': 2016,
						            'object': 'card',
						            'masked_number': '************1111'
						        }
						    },
						    'event_type': 'card_added',
						    'webhook_status': 'not_configured'
						}");
			Console.Write(e.Id);
		}

		public void TestListEvents()
		{
			ListResult result = FetchEventsList(null);
			String _nextOffset = "";
			Console.WriteLine("At\t\t\t\t\tEvent\t\t\t\tId\t\t\t\tWebhook");
			int i=0;
			while (_nextOffset != null && i++<3)
			{
				foreach(var item in result.List)
				{
					Event evt = item.Event;
					Console.WriteLine("{0}\t{1}\t{2}\t{3}",evt.OccurredAt, evt.EventType, evt.Id, evt.WebhookStatus);
				}
				result = FetchEventsList(_nextOffset);
				_nextOffset = result.NextOffset;

				//Subscription subs = evnt.Content.Subscription;
				//Console.WriteLine(subs);
			}
		}
		
		private ListResult FetchEventsList(string _offset)
		{
			Event.EventListRequest _listReq =  Event.List().Limit(10);
			if(_offset != null)
			{
				_listReq.Offset(_offset);
			}
			return _listReq.Request();
		}
		
		public void TestRetrieveEvent()
		{
			Event evt = Event.Retrieve("ev_IsLMimiO0BjMT3B8").Request().Event;
			Console.WriteLine(evt.WebhookStatus);
		}
		
		public void TestCreateSubscription()
		{
			string planId = "enterprise_half_yearly";
			
			EntityResult result = Subscription.Create()
				.PlanId(planId)
					.CustomerEmail("john@user.com")
					.CustomerFirstName("Ronald")
					.CustomerLastName("Simpson")
					.AddonId(1, "on_call_support")
//				.CreatedFromIp("354.8.9.0")
//				.CardGateway(GatewayEnum.Chargebee)
//				.CardNumber("4111111111111111")
//				.CardCvv("123")
//				.CardExpiryMonth(9)
//				.CardExpiryYear(2018)
//				.CardIpAddress("182.67.9.9")
				.Request();
			printFields (result.Customer, typeof(Customer));
			printFields (result.Card, typeof(Card));
			printFields (result.Subscription, typeof(Subscription));
		}

		public void TestListSubscriptions()
		{
			ListResult result = Subscription.List().Request();
			foreach (var item in result.List)
			{
				Subscription subs = item.Subscription;
				Console.WriteLine("{0}\t\t{1}\t\t{2}\t\t{3}", subs.Id, subs.CreatedAt, subs.ActivatedAt, subs.CancelledAt);
			}
		}
		
		public void TestRetrieveSubscriptions()
		{
			/*EntityResult result = Subscription.Create().PlanId("enterprise_half_yearly").Request();
			Subscription subs1 = result.Subscription;
			Console.WriteLine ("new sub is " + subs1.Id);*/

			EntityResult result = Subscription.Retrieve("1mqYqp8P7vZ82LA3Z").Request();
			printFields (result.Customer, typeof(Customer));
			printFields (result.Customer.BillingAddress, typeof(Customer.CustomerBillingAddress));
			printFields (result.Card, typeof(Card));
			printFields (result.Subscription, typeof(Subscription));
		}

		public void TestRetrieveInvoice()
		{
			EntityResult result = Invoice.Retrieve("6369").Request();
			Invoice invoice = result.Invoice;
			foreach(var li in invoice.LineItems)
			{
				Console.WriteLine("{0}\t{1}\t{2}\t{3}",li.UnitAmount(), li.EntityType(), li.LineItemType(), li.EntityId());

				//Console.WriteLine(item.EntityId);
				//Console.WriteLine(item.EntityType);
				//Console.WriteLine(item.LineItemType);
//				Console.WriteLine(li.UnitAmount);
				Console.WriteLine (li);
			}
		}

		public void TestUpdateSubscription()
		{
			EntityResult result = Subscription.Create().PlanId("enterprise_half_yearly").Request();
			Subscription subs1 = result.Subscription;

			Subscription.UpdateRequest r = Subscription.Update(subs1.Id).
				PlanId("basic").
					AddonId(1, "on_call_support").
					CardGateway(GatewayEnum.PaypalPro);
			result = r.Request();
			
			Subscription subs2 = result.Subscription;
		}
		
		public void TestCancelSubscription()
		{
			EntityResult result = Subscription.Create().PlanId("enterprise_half_yearly").Request();
			Subscription subs1 = result.Subscription;

			result = Subscription.Cancel(subs1.Id).Request();
			
			Subscription subs2 = result.Subscription;
		}

		public void TestHostedPageCheckout()
		{
			EntityResult result = HostedPage.CheckoutNew().SubscriptionPlanId("professional").Request();
			HostedPage hp = result.HostedPage;
			Console.WriteLine(hp.Url);
		}

		public void TestDiacritics()
		{
			Subscription.CreateRequest cReq = Subscription.Create().PlanId("basic").CustomerFirstName("Petr").CustomerLastName("Šrámek");
			EntityResult result = cReq.Request();
			Subscription subs1 = result.Subscription;
			
			result = Subscription.Cancel(subs1.Id).Request();
			
			Subscription subs2 = result.Subscription;
		}

		public void TestCustomFields() 
		{
			EntityResult result = Subscription.Retrieve("active_direct").Request();
			Subscription s = result.Subscription;
			Customer c = result.Customer;
			Console.WriteLine(c);
			Console.WriteLine(c.GetValue<String>("cf_mobile_number", false));
			Console.WriteLine(c.GetValue<String>("cf_domicile", false));
			//Console.WriteLine(subs2.PlanId);
		}

		public void CreateOrder(string InvoiceId) 
		{
			EntityResult result = Order.Create ()
				.InvoiceId (InvoiceId)
				.Status (Order.StatusEnum.New)
				.FulfillmentStatus ("Shipping")
				.Request ();
			Console.WriteLine (result.Order.Id);
		}

		public void RetrieveOrder(string OrderId)
		{
			EntityResult result = Order.Retrieve (OrderId).Request ();
			Console.WriteLine (result.Order.Id);
		}

		public void UpdateOrder(string OrderId)
		{
			EntityResult result = Order.Update (OrderId).Status (Order.StatusEnum.Processing).Request ();
			Console.WriteLine(result.Order.Id);
			Console.WriteLine(result.Order.Status);
		}

		public void ListAllOrders()
		{
			ListResult result = Order.List ().Request ();
			Console.WriteLine (result);
			Console.WriteLine (result.List.Capacity);
		}

		public void ListInvoiceOrders(string InvoiceId)
		{
			ListResult result = Order.OrdersForInvoice (InvoiceId).Request ();
			Console.WriteLine (result);
			Console.WriteLine (result.List.Capacity);
		}

		public static void updateAddress(){
			EntityResult result = Address.Update()
				.SubscriptionId("HqWAAxAPFHZPFp3g3")
				.Label("shipping_address")
				.FirstName("Benjamin")
				.LastName("Ross")
				.Addr("PO Box 9999")
				.City("Walnut")
				.State("California")
				.Zip("91789")
				.Country("United States").Request();
			Address address = result.Address;
			printFields (address, typeof(Address));		
		}

		public static void addAccountCredits()
		{  				
			EntityResult result =  Customer.AddAccountCredits("cbdemo_KyVqezP94gGB31")
				.Amount(500)
				.Description("Loyalty credits").Request();
			Customer customer = result.Customer;
			printFields (customer, typeof(Customer));
		}

		public static void deductAccountCredits()
		{
			EntityResult result = Customer.DeductAccountCredits("8avVGOkx8U1MX")
				.Amount(200)
				.Description("Correcting credits given by mistake").Request();
			Customer customer = result.Customer;
			printFields (customer,typeof(Customer));
		}

		public static void setAccountCredit()
		{
			EntityResult result = Customer.SetAccountCredits("cbdemo_KyVqezP94gGB31")
				.Amount(1200)
				.Description("Correcting credits given by mistake").Request();
			Customer customer = result.Customer;
			printFields (customer,typeof(Customer));
		}

		public void createInvoice(){
			EntityResult result = Invoice.Create()
				.CustomerId("2slhRVVBP4RyYhYTHp")
				.AddonId(1, "one-off_consulting_support")
				.AddonQuantity(1, 10)
				.AddonId(2, "non_rec_on_off")
				.ChargeAmount(1,1000)
				.ChargeDescription(1,"Support charge")
				.Coupon("one_time")
				.ShippingAddressLine1("AddrLine1")
				.ShippingAddressLine2("AddrLine2")
				.ShippingAddressCity("City")
				.ShippingAddressStateCode("WI")
				.ShippingAddressCountry("US")
				.ShippingAddressZip("55234")
				.Request();

			printInvoice (result.Invoice);
		}

		public void cretaePortalSession(){
			EntityResult result = PortalSession.Create()
				.RedirectUrl("https://cbdemo.com/users/3490343")
				.CustomerId("2slhRVVBP4RyYhYTHp").Request();
			printPortal(result.PortalSession);
		}

		public void retrievePortalSession(string portalId){
			EntityResult result = PortalSession.Retrieve(portalId).Request();
			printPortal(result.PortalSession);
		}

		public void activatePortalSession(){
			EntityResult result = PortalSession.Activate ("portal_2slhRVXAP5Tbt9N73K")
				.Token ("lt9cu3W1cu09RZwj9JeNS4XcWsTsmqjgyN").Request ();
			printPortal(result.PortalSession);
		}

		public void printPortal(PortalSession portal){
			foreach(PropertyDescriptor descriptor in TypeDescriptor.GetProperties(portal))
			{
				string name=descriptor.Name;
				object value=descriptor.GetValue(portal);
				Console.WriteLine("{0} = {1}",name,value);
			}
			foreach(PortalSession.PortalSessionLinkedCustomer custs in portal.LinkedCustomers){
				printFields (custs, typeof(PortalSession.PortalSessionLinkedCustomer));
			}
		}
		public void retrieveInv(string invId){
			EntityResult result = Invoice.Retrieve (invId).Request ();
			printInvoice (result.Invoice);
		}

		public void deleteInv(string invId){
			EntityResult result = Invoice.Delete(invId).Request();
			printInvoice (result.Invoice);
		}

		public void updCardForCust(string custId){
			EntityResult result = Card.UpdateCardForCustomer(custId)
				.Gateway(GatewayEnum.Chargebee)
				.FirstName("Richard")
				.LastName("Fox")
				.Number("4111111111111111")
				.Cvv("777")
				.ExpiryMonth(10)
				.ExpiryYear(2018)
				.IpAddress("145.78.2.3")
				.Request();
			printFields (result.Customer, typeof(Customer));
			printFields (result.Card, typeof(Card));
		}


		public static void printInvoice(Invoice inv){
			foreach(PropertyDescriptor descriptor in TypeDescriptor.GetProperties(inv))
			{
				string name=descriptor.Name;
				object value=descriptor.GetValue(inv);
				Console.WriteLine("{0} = {1}",name,value);
			}
			foreach(Invoice.InvoiceLineItem li in inv.LineItems){
				printFields (li, typeof(Invoice.InvoiceLineItem));
			}
//			foreach(Invoice.InvoiceDiscount dis in inv.Discounts){
//				printFields (dis, typeof(Invoice.InvoiceDiscount));
//			}
			if (inv.Taxes != null) {
				foreach (Invoice.InvoiceTax tax in inv.Taxes) {
					printFields (tax, typeof(Invoice.InvoiceTax));
				}
			}
			foreach(Invoice.InvoiceLinkedTransaction txn in inv.LinkedTransactions){
				printFields (txn, typeof(Invoice.InvoiceLinkedTransaction));
			}
//			foreach(Invoice.InvoiceLinkedOrder ord in inv.LinkedOrders){
//				printFields (ord, typeof(Invoice.InvoiceLinkedOrder));
//			}
//			printFields (inv.BillingAddress, typeof(Invoice.InvoiceBillingAddress));
//			printFields (inv.ShippingAddress, typeof(Invoice.InvoiceShippingAddress));
		}

		public static void printFields(object obj, Type type){
			if (obj == null) {
				return;
			}
			Console.WriteLine(type.Name);
			MethodInfo[] methods = type.GetMethods();
			foreach (MethodInfo info in methods)
			{
				string name = info.Name;
				try{
					object val = info.Invoke (obj, null);
					Console.WriteLine("{0} = {1}",name,val);
				}catch(Exception exp){
				}
			}
		}


		public static void testPoNoCreateSub(){
			EntityResult result = Subscription.Create ().PlanId ("basic")
				.PoNumber("23232")
				.InvoiceNotes("Invoice notes")
				.CustomerEmail ("email@email.com").Request();
				
			Console.WriteLine (result.Subscription.Id);
			Console.WriteLine (result.Subscription.InvoiceNotes);
			Console.WriteLine (result.Subscription.PoNumber);

		}

		public static void testPoNoCreateSubForCust(){
			EntityResult result = Subscription.CreateForCustomer ("__dev__KyVpYtP9kOEmD5")
				.PlanId ("basic").PoNumber("#4321")
				.InvoiceNotes("Notes for the sub create for customer")
				.Request();
			Console.WriteLine (result.Subscription.Id);
			Console.WriteLine (result.Subscription.PoNumber);
			Console.WriteLine (result.Subscription.InvoiceNotes);

		}

		public static void createSubForCust(string custId){
			EntityResult result = Subscription.CreateForCustomer (custId)
				.PlanId ("enterprise").PoNumber("#4333")
				.InvoiceNotes("Notes for the sub create for customer")
				.Header ("chargebee-event-email", "all-disabled")
				.Header("chargebee-event-webhook","all-disabled")
				.Request();
			Console.WriteLine (result.Subscription.Id);
			Console.WriteLine (result.Subscription.PoNumber);
			Console.WriteLine (result.Subscription.InvoiceNotes);

		}

		public static void hostedPageRedirectUrl(){
			EntityResult result = HostedPage.CheckoutNew ()
				.SubscriptionPlanId("silver")
				.AddonId(0, "sms_pack")
				.RedirectUrl("http://www.redirecturl.com")
				.CancelUrl("http://www.cancelurl.com")
				.Request();

			Console.WriteLine (result.HostedPage.Url);
		}

		public static void checkoutExistingRedirectNCancelUrl() {
			EntityResult result = HostedPage.CheckoutExisting()
				.SubscriptionId("__dev__KyVpYtP9kOVgE9")
				.RedirectUrl("http://www.redirecturl.com")
				.CancelUrl("http://www.cancelurl.com")
				.Request();

			Console.WriteLine(result.HostedPage.Url);
		}

		public static void updateCardRedirectNCancelUrl() {
			EntityResult result = HostedPage.UpdateCard ()
								.CustomerId ("__dev__KyVpYtP9kcEQfR")
				.RedirectUrl("http://www.asdsc.com")
				.CancelUrl("http://asds.com")
				.Request ();

			Console.WriteLine(result.HostedPage.Url);
		}

		public static void planNotes() {
			EntityResult result = Plan.Create()
				.Id("silver")
				.Name("Silver")
				.InvoiceName("sample plan")
				.Price(5000)
				.InvoiceNotes("This is the invoice notes for the plan")
				.Request();

			EntityResult result1 = Plan.Retrieve ("silver").Request ();
			Console.WriteLine ( result1.Plan.InvoiceNotes);
		}

		public static void addonNotes() {
			EntityResult result = Addon.Create()
				.Id("sms_pack")
				.Name("Sms Pack")
				.InvoiceName("sample data pack")
				.ChargeType(Addon.ChargeTypeEnum.Recurring)
				.Price(200)
				.Period(1)
				.PeriodUnit(Addon.PeriodUnitEnum.Month)
				.InvoiceNotes("Invoice Notes for addon")
				.Type(Addon.TypeEnum.OnOff).Request();

			EntityResult result1 = Addon.Retrieve("sms_pack").Request();
			Console.WriteLine (result1.Addon.Id);
			Console.WriteLine (result1.Addon.InvoiceNotes);
		}
			
		public static void createInvoiceForCharge() {
			EntityResult result = Invoice.Create()
				.CustomerId("__dev__KyVpYtP9kcEQfR")
				.ChargeAmount(1,1000)
				.PoNumber("%$121212")
				.ChargeDescription(1,"Support charge").Request();
			Console.WriteLine (result.Invoice.Id);

			EntityResult result1 = Invoice.Charge()
				.SubscriptionId("__dev__KyVpYtP9kcEQfR")
				.Amount(1000)
				.Description("Support charge")
				.PoNumber("1232131asdsad").Request();
			Console.WriteLine (result1.Invoice.Id);

			EntityResult result2 = Invoice.ChargeAddon()
				.SubscriptionId("__dev__KyVpYtP9kcEQfR")
				.AddonId("day-pass")
				.AddonQuantity(2)
				.PoNumber("Poa asdsadasd")
				.Request();
			Console.WriteLine (result2.Invoice.Id);
		}

		public static void amountdue() {

			EntityResult result = Invoice.Retrieve("__demo_inv__19").Request();
			Invoice invoice = result.Invoice;
			Console.WriteLine (invoice.AmountDue);
			Console.WriteLine (invoice.Amount);
		}

		public static void paymentMethodPayPalCreateSub(){

			EntityResult result = Subscription.Create()
				.PlanId("no-trial")
				.PaymentMethodReferenceId("B-2W525066JC884990M")
				.PaymentMethodType(TypeEnum.PaypalExpressCheckout)
				.Request();
			Console.WriteLine (result.Subscription.Id);
		
				
		}

		public static void  paymentMethodAmzCreateSub() {
						EntityResult result1 = Subscription.Create()
							.PlanId("no-trial")
							.PaymentMethodReferenceId("B-2W525066JC884990M")
							.PaymentMethodType(TypeEnum.AmazonPayments)
							.Request();
		}

		public static void paymentMethodPayPalUpdateSub(){
			EntityResult result = Subscription.Update ("__dev__KyVqjBPB85nZsK")
				.PaymentMethodReferenceId("B-2W525066JC884990M")
				.PaymentMethodType(TypeEnum.PaypalExpressCheckout)
				.Request();
			Console.WriteLine (result.Customer.PaymentMethod.PaymentMethodType());
		}

		public static void paymentMethodCreateCustomer() {
			EntityResult result = Customer.Create ()
								.FirstName ("John")
				.PaymentMethodReferenceId ("49288584")
				.PaymentMethodType (TypeEnum.Card)
				.PaymentMethodGateway (GatewayEnum.Braintree)
				.Request ();

			Console.WriteLine (result.Customer.PaymentMethod.PaymentMethodType ());
			Console.WriteLine (result.Customer.PaymentMethod.ReferenceId ());

		}


		public static void collectPayement() {
			EntityResult result = Invoice.CollectPayment ("__demo_inv__12").Request ();
			Console.WriteLine (result.Invoice.Status);
		}

		public void recordPartialPayment(String invId, int amount){
			EntityResult result = Transaction.RecordPayment(invId)
				.PaymentMethod(PaymentMethodEnum.BankTransfer)
				.Amount(amount)
				.PaidAt(1394532759).Request();
			Transaction transaction = result.Transaction;
			Invoice invoice = result.Invoice;
			printInvoice (invoice);
		}

		public void testCreatePlan() {
			EntityResult result = Plan.Create()
				.Id("silver")
				.Name("Silver")
				.InvoiceName("sample plan")
				.Price(5000)
//				.DowngradePenalty(12.5D)
				.InvoiceNotes("This is the invoice notes for the plan")
				.Request();

			EntityResult result1 = Plan.Retrieve ("silver").Request ();
			Console.WriteLine ( result1.Plan.InvoiceNotes);
		}

		public void testUpdatePlan() {
			EntityResult result =  Plan.Update("cbee_multiple_site_plan")
				.Id("silver")
				.Name("Silver")
				.InvoiceName("sample plan")
				.Price(5000)
				.DowngradePenalty(12.5D)
				.InvoiceNotes("This is the invoice notes for the plan")
				.Request();
			printFields (result.Plan, typeof(Plan));
			EntityResult result1 = Plan.Retrieve ("silver").Request ();
			printFields (result1.Plan, typeof(Plan));
		}

		public static void voidInvoice(string invId) {
			EntityResult result = Invoice.VoidInvoice(invId).Request();
			Invoice invoice = result.Invoice;
			printInvoice (invoice);
		}

		public static void _main() {
			//testPoNoCreateSub ();
			//testPoNoCreateSubForCust ();
			//planNotes ();
			//addonNotes();
			//hostedPageRedirectUrl ();
			//checkoutExistingRedirectNCancelUrl ();
			//createInvoiceForCharge ();
			//updateCardRedirectNCancelUrl ();
			//amountdue ();
			//paymentMethodPayPalCreateSub ();
			//paymentMethodAmzCreateSub ();
			//paymentMethodPayPalUpdateSub ();
			//paymentMethodCreateCustomer ();
			collectPayement ();
		}

		public static void recordRefund(){
			EntityResult result = Invoice.RecordRefund("85")
				.Memo("Refunding as customer canceled the order.")
//				.TransactionAmount(800)
				.TransactionPaymentMethod(PaymentMethodEnum.BankTransfer)
				.TransactionDate(1435777328)
				.TransactionReferenceNumber("876876")
				.Request();
			printInvoice (result.Invoice);
		}

		public static void Main(string[] args) 
		{
			ApiConfig.Proto = "https";
			ApiConfig.DomainSuffix = "chargebee.com";
			ApiConfig.Configure("mannar-test", "test___dev__ULjDUaIoajPKsrz9uigpFWUSEO0ykwaC");

//			try{
				//_main();
			voidInvoice("98");
//			}catch(ApiException e) {
//				Console.WriteLine (e.ApiErrorCode);
//				Console.WriteLine (e.Param);
//				Console.WriteLine (e.HttpStatusCode);
//			}


//			Sample s = new Sample();
//			s.Configure ();
//			s.testUpdatePlan ();
			//			s.TestRetrieveSubscriptions();
			//			s.TestRetrieveInvoice();
			//			s.TestCustomFields();
			//			s.TestListSubscriptions();
			//			s.TestListEvents();
			//			s.TestSerializeEvent();
			//		    s.TestRetrieveEvent();
			//		    s.TestHostedPageCheckout();
			//		    s.TestDiacritics();
			//			s.CreateOrder ("__demo_inv__24");
			//			s.RetrieveOrder ("__dev__XpbGU6hOxIoCOO8");
			//			s.UpdateOrder ("__dev__XpbGU6hOxIoCOO8");
			//			s.ListAllOrders ();
			//			s.ListInvoiceOrders ("__demo_inv__24");
			//			s.retrieveInv("38");s.createInvoice();
			//			s.cretaePortalSession ();
			//			s.retrievePortalSession ("portal_2slhRVXAP5TdWAv74L");
			//			s.activatePortalSession ();
		}


		public static  void dateConversion(){
			//DateTime dt = DateTime.Now;
			//			DateTime m_unixTime = new DateTime (1970, 1, 1);
			//			Console.WriteLine ("Constant variable m_unixTime" + m_unixTime);
			//			Console.WriteLine (m_unixTime.ToUniversalTime ().ToUniversalTime ());
			//			Console.WriteLine("For local time from utc" + 
			//				m_unixTime.ToUniversalTime().AddHours (5).AddMinutes(30)); // for local time
			//
			//
			//			DateTime dt = new DateTime (1970,1, 1, 0, 0, 0);
			//			Console.WriteLine (dt.ToString());
			//Console.WriteLine ( dt.ToUniversalTime ());
			//dt = dt.AddHours (5).AddMinutes(30);
			//Console.WriteLine ("After adding 5:30 " + dt.ToUniversalTime ());
			//			if (dt.Equals(m_unixTime)) {
			//				Console.WriteLine ("It is less than Jan 1, 1970");
			//			}
			//			Console.WriteLine ((dt.ToUniversalTime() - m_unixTime).TotalSeconds);
			//Console.WriteLine (ApiUtil.ConvertToTimestamp (dt).ToString());
		}
		 

	}
}
	