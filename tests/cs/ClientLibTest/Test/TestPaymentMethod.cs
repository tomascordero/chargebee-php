using System;
using ChargeBee.Api;
using ChargeBee.Models;

namespace ClientLibTest
{
	public class TestPaymentMethod
	{
		public TestPaymentMethod ()
		{

		}
		public void testRetrieveCustomer() {

			//EntityResult result  = ChargeBee.Models.Customer.Retrieve ("1sGeZ2FOvI0H2E4y").Request ();
			EntityResult result  = ChargeBee.Models.Customer.Retrieve ("1sGeZ2FOvI0UdL59").Request ();
			Console.WriteLine (result.Customer.Id);
			Console.WriteLine (result.Customer.Email);
			Console.WriteLine (result.Customer.PaymentMethod.PaymentMethodType());
			Console.WriteLine (result.Customer.PaymentMethod.ReferenceId());
			Console.WriteLine (result.Customer.PaymentMethod.Status());
		}

		public void testRetrieveCard() {
			//EntityResult result = Card.Retrieve("1sGeZ2FOvI0H2E4y").Request();
			EntityResult result = Card.Retrieve("1sGeZ2FOvI0UdL59").Request();
			Card card = result.Card;
			Console.WriteLine (card.Status);
			Console.WriteLine (card.Iin);
		}

		public void updateAmazonPaymentWithCard() {
			EntityResult result = Card.UpdateCardForCustomer("1sGeZ2FOvI0H2E4y")
			//	.Gateway(GatewayEnum.Chargebee)
				.FirstName("Richard")
				.LastName("Fox")
				.Number("4012888888881881")
				.ExpiryMonth(10)
				.ExpiryYear(2015)
				.Cvv("999").Request();
			Console.WriteLine (result.Customer.PaymentMethod.PaymentMethodType());
			Console.WriteLine (result.Customer.PaymentMethod.ReferenceId());
			Console.WriteLine (result.Customer.PaymentMethod.Status());
		}

		public void testTxn() {
			//EntityResult result = Transaction.Retrieve ("txn_1sGeZ2FOvHzDwG4Y").Request ();
			//EntityResult result = Transaction.Retrieve ("txn_1sGeZ2FOvI530V5R").Request ();
			EntityResult result = Transaction.Retrieve ("txn_1sGeZ3FOuvm01aNH").Request ();
			Transaction transaction = result.Transaction;
			Console.WriteLine (transaction.PaymentMethod);
			Console.WriteLine (transaction.TransactionType);
		}
	}
}

