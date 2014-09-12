using System;
using System.Net;
using System.IO;
using System.Text;
using System.Globalization;

using ChargeBee.Api;
using ChargeBee.Models;
using ChargeBee.Models.Enums;
using ChargeBee.Exceptions;

public class ErrorTest {

	private void Configure()
	{
		ApiConfig.Proto = "http";
		ApiConfig.DomainSuffix = "localcb.in:8080";
		//"freshdesk.com";
		ApiConfig.Configure("mannar-test", "test___dev__n5XdbThZvggjaINjwyaR8lX0sTbU4gSF");
	}

	private void DoTest() {

		try {
			EntityResult result = Subscription.Create()
				.PlanId("no-trial")
				.Coupon("wow")
				.CustomerEmail("john@user.com")
				.CustomerFirstName("John")
				.CustomerLastName("Doe")
				.CustomerPhone("+1-949-999-9999")
				.BillingAddressFirstName("John")
				.BillingAddressLastName("Doe")
				.BillingAddressLine1("PO Box 9999")
				.BillingAddressCity("Walnut")
				.BillingAddressState("CA")
				.BillingAddressZip("91789")
				.BillingAddressCountry("US")
				.AddonId(1,"day-pass")
				.CardNumber("4111 1111 1111 1111")
				.CardCvv("234") //
				.CardExpiryMonth(12) //
				.CardExpiryYear(2014) //
				.AddonQuantity(1,2)
				.Request();

			Subscription s = result.Subscription;
			Customer c = result.Customer;
			Card cd = result.Card;
			Invoice i = result.Invoice;
		} catch(PaymentException e) {
			Console.WriteLine (e);
			//First check for specific card parameter names and show appropriate message.
			//We recommend you to validate the input at the client side itself to catch simple mistakes.
			if ("card[number]".Equals(e.Param)) {
				Console.WriteLine("Inside Invalid Card " + e.Message);
				// Ask your user to recheck the card number. A better way is to use
				// Stripe's https://github.com/stripe/jquery.payment for validating it in the client side itself.
				//}else if(<other card parameters> ...){
				// ...
			} else {
				Console.WriteLine("Inside other payment errors " + e.Code + " " + e.Param);
				//Provide a standard message to your user to recheck his card details or provide a different card.
				// Like  'Sorry,there was a problem when processing your card, please check the details and try again'.
			}
		} catch(InvalidRequestException e){
			Console.WriteLine("Inside InvalidRequest " + e.Message);
			Console.WriteLine(e);
			// For coupons you could decide to provide specific messages by using
			// the 'code' attribute in the error.
			if ("coupon".Equals (e.Param)) {
				if ("resource_not_found".Equals (e.Code)) {
					Console.WriteLine ("Coupon not found");
					// Inform user to recheck his coupon code.
				} else if ("resource_limit_exhausted".Equals (e.Code)) {
					// Inform user that the coupon code has expired.
				} else if ("invalid_request".Equals (e.Code)) {
					// Inform user that the coupon code is not applicable for his plan(/addons).
				} else {
					// Inform user to recheck his coupon code.
				}
			}
		} catch(OperationFailedException e){
			Console.WriteLine("Inside OperationFailed " + e.Message);
			Console.WriteLine(e);
			// Indicates that the request parameters were right but the request couldn't be completed.
			// The reasons might be "api_request_limit_exceeded" or could be due to an issue in ChargeBee side.
			// These should occur very rarely and mostly be of temporary nature.
			// You could ask your user to retry after some time.
		} catch(ApiException e){
			Console.WriteLine("Inside APIException " + e.Code);
			Console.WriteLine(e);
			// Handle the other ChargeBee API errors. Mostly would be setup related
			// exceptions such as authentication failure.
			// You could ask users contact your support.
		} catch(WebException e){
			Console.WriteLine("Inside WebException " + e.Message);
			Console.WriteLine (e.ToString());
			// Handle IO exceptions such as connection timeout, request timeout etc.
			// You could give a generic message to the customer retry after some time.
		} catch(Exception e){
			Console.WriteLine("Inside Exception " + e.Message);
			Console.WriteLine (e.ToString());
			// These are unhandled exceptions (Could be due to a bug in your code or very rarely in client library).
			// You could ask users contact your support.
		}
	}

	public static void Main(string[] args){
		ErrorTest et = new ErrorTest ();
		et.Configure ();
		et.DoTest ();
	}

}