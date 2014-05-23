<?php
set_include_path ('.:/Users/rr');

// require_once(dirname(__FILE__) . 'chargebee/lib/ChargeBee.php');
require('lib/ChargeBee.php');

// ChargeBee_Environment::$scheme = "http";
// ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";
// ChargeBee_Environment::configure("mannar-test", "test___dev__JtPnhGricucdRRBnI2Vi0NVtoCbbrvg7c");

// ChargeBee_Environment::$chargebeeDomain = "stagingcb.com";
// ChargeBee_Environment::configure("mannar-test", "asmbHDtNLNS17eXQJNic6AJquLOgoZDm");

ChargeBee_Environment::configure("rrcb-test", "jaGdadHeCQxfmFQG2sEgSrzHdyt23cwcd");
// ChargeBee_Environment::configure("self-test", "4P0YLcdxIxAB1k736JI7XqmSrmF88BKEX");

function retrieveSubscription()
{
	$result = ChargeBee_Subscription::retrieve('1qBnWmGOIiLbkP1j');
  printResult($result);
  // echo $result->subscription()->totalDues;
  // echo $result->subscription()->status;
}

function testDiacritics()
{
	$result = ChargeBee_Subscription::create(array(
	  "customer" => array(
	    "firstName" => "Petr",
	    "lastName" => "Šrámek"
	    ),
		"planId" => "basic"
		));
}

function createSubscription()
{
	$result = ChargeBee_Subscription::create(array(
	  "customer" => array(
	    "cf_company_name" => "Mannar",
	    "cf_security_no" => 101,
	    "cf_music_preference" => "Celtic"
	    ),
		"planId" => "basic"
		));
  // $subscription = $result->subscription();
	printSubscription($result);
	echo $result->customer()->param("cf_security_no_");
	//echo $result->customer()->cfSecurityNon;
}

function createSubscriptionWithAddons() 
{
  $result = ChargeBee_Subscription::create(array(
    "planId" => "basic", 
    "customer" => array(
      "email" => "john@user.com", 
      "firstName" => "John", 
      "lastName" => "Wayne"
    ), 
    "addons" => array(
      array(
      "id" => "ssl"
    ),array(
      "id" => "sms_credits",
      "quantity" => "10"
    )
    )));
  // $subscription = $result->subscription();
  // $customer = $result->customer();
  // $card = $result->card();
  printSubscription($result);
}

function updateSubscriptionWithAddons()
{
  $result = ChargeBee_Subscription::update("3msf5ct37h6qcb91r6", array(
    "planId" => "basic", 
    "addons" => array(array(
      "id" => "ssl"
    ))));
  printSubscription($result);
}

function allSubscription()
{
	$resList = ChargeBee_Subscription::all(array('limit'=>2));
	echo $resList->nextOffset();
	if($resList->nextOffset()) {
	  $resList = ChargeBee_Subscription::all(array("limit" => 2,  "offset" => $resList->nextOffset()));
    echo $resList->nextOffset();
  }

}


function createSubscriptionEstimate()
{
  $result = ChargeBee_Estimate::createSubscription(array(
    "subscription" => array(
      "planId" => "basic"
    )));
	printEstimate($result);
}

function updateCard()
{
  $result = ChargeBee_Subscription::retrieve("trial");
  $result = ChargeBee_Card::updateCardForCustomer("trial", array(
		"gateway" => "chargebee", 
		"firstName" => "fName", 
		"lastName" => 'lName', 
		#"number" => '4111111111111111', 
		"expiryMonth" => 12, 
		"expiryYear" => 2013, 
		"cvv" => "121")); 
	  print_r($result->card());
}

function checkoutExistingSubscription()
{
  $result = ChargeBee_HostedPage::checkoutExisting(array(
    "subscription" => array(
      "id" => "374CRBOWmlqmv7", 
      "planId" => "basic"
    ), 
    "card" => array(
      "gateway" => "chargebee"
    )));
	printHostedPage($result);
}

function reactivateSubscription()
{
  $result = ChargeBee_Subscription::reactivate("canceled_nocard", array(
    "trialPeriodDays" => "10"
  ));
  printResult($result);
}

function retrieveEvent()
{
	$result = ChargeBee_Event::retrieve('ev_2tTR52ZSO78CaU196d');
	printEvent($result);
	printSubscription($result);
}

function allEvents()
{
	$all = ChargeBee_Event::all(array(
	  "limit" => 5));
	foreach($all as $entry){
	  printEvent($entry);
	}
}

function printResult($result)
{
	printSubscription($result);

}

function printSubscription($result)
{
	$subscription = $result->subscription();
	if(is_null($subscription))
		return;
	echo "customer object is ";
	print_r($result->customer());
	echo "subscription object is ";
	print_r($subscription);	
	$addons = $subscription->addons;
	if(!is_null($addons))
	{
		// print_r($addons) . "\n";
		foreach($addons as $a){
			echo "subscription addon object is ";
			print_r($a) . "\n";
			echo "addon id is $a->id\n";
			echo "addon quantity is $a->quantity\n";
		}
	}
}

function printTransaction($result)
{
	$transaction = $result->transaction();
	if(is_null($transaction))
		return;
	echo "transaction object is ";
	print_r($transaction);
}

function printEvent($result)
{
	$event = $result->event();
	// print_r($event);
	echo "event attributes are \n";
	echo $event->id()."\n";
	echo $event->occurredAt."\n";
	echo $event->webhookStatus."\n";
	echo $event->eventType."\n";
	$content = $event->content();
	printSubscription($content);
	printTransaction($content);
}

function printEstimate($result)
{
	$estimate = $result->estimate();
	echo "Estimate attributes are \n";
	print_r($estimate);
}

function printHostedPage($result)
{
	$hostedPage = $result->hostedPage();
	echo "hostedPage attributes are \n";
	echo $hostedPage->id."\n";
	echo $hostedPage->type."\n";
	echo $hostedPage->url."\n";
	echo $hostedPage->state."\n";
}

function address() 
{
  $result = ChargeBee_Address::update(array(
    "subscriptionId" => "trial", 
    "label" => "shipping_address", 
    "addr" => "340 S LEMON AVE #1537", 
    "city" => "Walnut", 
    "state" => "CA", 
    "zip" => "91789", 
    "country" => "United States"));
    $address = $result->address();
  	print_r($address);
}

function webhook()
{
  $event = ChargeBee_Event::deserialize('{ "content": { "card": { "card_type": "american_express", "customer_id": "nonrenewing_today", "expiry_month": 10, "expiry_year": 2013, "gateway": "chargebee", "iin": "378282", "last4": "0005", "masked_number": "378282*****0005", "object": "credit_card", "status": "valid" }, "customer": { "card_status": "valid", "created_at": 1333631454, "email": "nonrenewing_today@test.com", "first_name": "nonrenewing_today", "id": "nonrenewing_today", "object": "customer" }, "subscription": { "activated_at": 1336223455, "cancelled_at": 1338901865, "created_at": 1333631454, "current_term_end": 1338901865, "current_term_start": 1336223454, "due_invoices_count": 0, "id": "nonrenewing_today", "object": "subscription", "plan_id": "basic", "plan_quantity": 1, "status": "cancelled", "trial_end": 1336223454, "trial_start": 1333631454 } }, "email_status": "not_applicable", "event_type": "subscription_canceled", "id": "ev___dev__KyVq6jNZTDmKA2", "object": "event", "occurred_at": 1338901865, "webhook_status": "scheduled" }');
  echo "event attributes are \n";
	echo $event->id."\n";
	echo $event->occurredAt."\n";
	echo $event->webhookStatus."\n";
	echo $event->eventType."\n";
	$content = $event->content();
	printSubscription($content);
	printTransaction($content);
}

function plans()
{
  $all = ChargeBee_Plan::all(array("limit" => 5));
  foreach($all as $entry){
    $plan = $entry->plan();
    echo $plan->id;
  }
  print_r($all);
}

function schoolpage() 
{
  ChargeBee_Environment::configure('rrcb-test','jaGdadHeCQxfmFQG2sEgSrzHdyt23cwcd');    
  print("configured");
  // $result = ChargeBee_HostedPage::checkoutNew(array(
  //   "subscription" => array(
  //     "id" => "2222", 
  //     "planId" => "BASIC"
  //   ), 
  //   "addons" => array(array(
  //    "id" => "G-KUWAIT",
  //  "quantity" => 2
  //   )),
  //   "customer" => array(
  //     "email" => "riyaz291990@gmail.com", 
  //     "firstName" => "Riyaz", 
  //     "lastName" => "Riyaz"
  //   ), 
  //   "card" => array(
  //     "gateway" => "chargebee"
  //   )));
  // $hostedPage = $result->hostedPage();
  // print_r($hostedPage);
  $result = ChargeBee_Coupon::all();
  print_r($result);
}

function invoiceTransactions()
{
  $all = ChargeBee_Transaction::transactionsForInvoice("INV587");
  foreach($all as $entry){
    $transaction = $entry->transaction();
    print_r($transaction);
  }
  
}

function deleteCard()
{
  $result = ChargeBee_Card::deleteCardForCustomer("1mejvOgODLwVUI4c");  
}

function retrieveCoupon()
{
    $result = ChargeBee_Coupon::retrieve("BETA20%OFF");
    print_r($result);
}
// retrieveSubscription();
// plans();
// createSubscription();
// checkoutExistingSubscription();
// allSubscription();
// updateCard();
// retrieveEvent();
// allEvents();
// reactivateSubscription();
// address();
// webhook();
//schoolpage();
// createSubscriptionWithAddons();
// updateSubscriptionWithAddons();
//createSubscriptionEstimate();
// testDiacritics();
// invoiceTransactions();
// deleteCard();
retrieveCoupon();
?>