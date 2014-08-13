<?php
/**
 * Contains sample codes & functions to work with our php library.
 */

/**
 * Require the chargebee-php library from the code base that is relative to the
 * chargebee-app directory
 */
require('../../php/lib/ChargeBee.php');

/**
 * Below are the setting to be used if you are testing with the local server.
 */
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";

/**
 * Below are the configuration setting our customers will use to connect to our production server.
 */
//ChargeBee_Environment::$chargebeeDomain = "stagingcb.com";
ChargeBee_Environment::configure("mannar-test", "test___dev__dJIiuf4qr6gcuTiPLiBSY1Zm40o4vcdFAT");
// ChargeBee_Environment::configure("rrcb-test", "jaGdadHeCQxfmFQG2sEgSrzHdyt23cwcd");

/**
 * Below are the functions to demonstrate the API access. There are few utility functions towards the end for reuse.
 */
function retrieveSubscription()
{
	$result = ChargeBee_Subscription::retrieve('HvQquIyObCHxeP1vi');
  printResult($result);

  // echo $result->subscription()->hasScheduledChanges;
  // echo $result->subscription()->totalDues;
  // echo $result->subscription()->status;
}

function retrieveSubWithScheduledChanges()
{
	$result = ChargeBee_Subscription::retrieveWithScheduledChanges("HvQquIyObCHxeP1vi");
	printSubscription($result);
	// printResult($result);
}

function removeScheduledChanges()
{
	$result = ChargeBee_Subscription::removeScheduledChanges("HvQquIyObCHxeP1vi");
	printSubscription($result);
	// printResult($result);
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

function retrievCustomField(){
 $result = ChargeBee_Subscription::retrieve("active_direct");
 $customer = $result->customer();
 print_r($customer->cfSocialSecurityNo);
 print_r($customer->cfGender);
}

function createSubscriptionWithAddons()
{
  $result = ChargeBee_Subscription::create(array(
    "planId" => "bc1",
    "customer" => array(
      "email" => "john@user.com",
      "firstName" => "John",
      "lastName" => "Wayne"
    ),
    "addons" => array(array(
      "id" => "ssl"
    ))));
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

/*
Utility functions.
*/
function printResult($result)
{
	printSubscription($result);
  printTransaction($result);
  printEvent($result);
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

function createInvForCharge(){
	$result = ChargeBee_Invoice::charge(array(
	  "customerId" => "future_billing", 
	  "amount" => 1000, 
	  "description" => "Support charge",
	  "coupon" => "beta"));
	$invoice = $result->invoice();
	print_r($invoice);
}

function createInvForAddon(){
	$result = ChargeBee_Invoice::chargeAddon(array(
	  "customerId" => "trial1", 	  
	  "addonId" => "day_pass",
	  "addonQuantity" => 2,
	  "coupon" => "web_0018"));
	$invoice = $result->invoice();
	print_r($invoice);
}

function estimateRenewal()
{
	$result = ChargeBee_Estimate::renewalEstimate("HvQquIyObCHxeP1vi" , array(
		"includeDelayedCharges" => "false"
	));
	$estimate = $result->estimate();
	print_r($estimate);
}


function addAddonAtTermEnd()
{
	$result = ChargeBee_Subscription::chargeAddonAtTermEnd("HvQquIyObCHxeP1vi", array(
	  "addonId" => "one-off_consulting_support", 
	  "addonQuantity" => 10));
	$estimate = $result->estimate();
	print_r($estimate);
}

function addChargeAtTermEnd()
{
	$result = ChargeBee_Subscription::addChargeAtTermEnd("HvQquIyObCHxeP1vi", array(
	  "amount" => 1020, 
	  "description" => "Support charge"));
	$estimate = $result->estimate();
	print_r($estimate);
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

function createPlan()
{
    $result = ChargeBee_Plan::create(array(
        "id" => "my_plan",
        "name" => "My Plan",
        "invoice_name" => "my plan",
		"description" => "<script>alert('Hello')</script>",
        "period" => 12,
        "period_unit" => "month",
        "price" => 5000,
        "downgrade_penalty" => 12.2,
        "setup_cost" => 1200,
        "billing_cycles" => 10,
        "trial_period" => "2",
        "trial_period_unit" => "month",
		"enabledInHostedPages" => FALSE));
    $plan = $result->plan();
    print_r($plan);
}

function updPlan()
{
	$result = ChargeBee_Plan::update("my_plan", array(
	  "invoiceName" => "my sample plan",
	  "enabledInHostedPages" => TRUE,
	  "setupCost" => 1500));
	$plan = $result->plan();
	print_r($plan);
}

function delPlan()
{
	$result = ChargeBee_Plan::delete("my_plan");
	$plan = $result->plan();
	print_r($plan);	
}

function retrievePlan()
{
	$result = ChargeBee_Plan::retrieve("basic");
	$plan = $result->plan();
	print_r($plan);
	// echo $plan->enabledInHostedPages;
}

function createAddon()
{
    $result = ChargeBee_Addon::create(array(
        "id" => "my_addon",
        "name" => "My Addon",
        "invoice_name" => "my addon",
		"description" => "You can let prospects or buyers try out your product or service for a limited period before switching them over to a paid subscription. Trials are independent of the normal billing cycle and plan price.",
	"charge_type" => "recurring",
	"period" => 12,
	"period_unit" => "month",
	"price" => 200,
	"type" => "quantity",
	"unit" => "Agent"));
    $addon = $result->addon();
    print_r($addon);
}

function retrieveAddon()
{
	$result = ChargeBee_Addon::retrieve("my_addon");
	$addon = $result->addon();
	print_r($addon);
}

function delAddon()
{
	$result = ChargeBee_Addon::delete("my_addon");
	$addon = $result->addon();
	print_r($addon);
}

function updAddon()
{
	$result = ChargeBee_Addon::update("my_addon", array(
	  "invoiceName" => "sample data pack",
	  "description" => "subscriptions can use this addon but subscriptions already on it will continue to renew. Once an addon has been archived, it cannot be edited or used again and the addon cannot be un-archived. "));
	$addon = $result->addon();
	print_r($addon);
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


function retrieveSubscriptionsForCust()
{
    $all = ChargeBee_Subscription::subscriptionsForCustomer("active_direct", array("limit" => 5));
    foreach($all as $entry){
        //printSubscription($entry);
        $subscription = $entry->subscription();
        print_r($subscription->id);
    }
}

function createForSub()
{
    $result = ChargeBee_Subscription::createForCustomer("active_direct", array(
        "planId" => "basic",
        "addons" => array(array(
        "id" => "ssl"
        )
    )));
    $subscription = $result->subscription();
    $customer = $result->customer();
    $card = $result->card();
    $invoice = $result->invoice();
    print_r($result);
}

function listSubForCust()
{
    $all = ChargeBee_Subscription::subscriptionsForCustomer("active_direct", array(
    "limit" => 5));
        foreach($all as $entry){
        $sub= $entry->subscription();
	print_r($sub->planId);
    }
}

function createComment()
{
    $result = ChargeBee_Comment::create(array(
        "entityType" => "subscription",
        "entityId" => "test",
        "notes" => "This is a test comment"));
    $comment = $result->comment();
    print_r($comment);
}

function retrieveComment()
{
    $result = ChargeBee_Comment::retrieve("cmt___dev__8avbKOSQjR3mW");
    $comment = $result->comment();
    print_r($comment);
}

function listComment()
{
    $all = ChargeBee_Comment::all(array(
    "limit" => 5));
    foreach($all as $entry){
    $comment = $entry->comment();
    print_r($comment);
    }
}

function delComment()
{
    $result = ChargeBee_Comment::delete("cmt___dev__8avbKOSQjR3mW");
    $comment = $result->comment();
    print_r($comment);
}

function refundInvoice()
{
    $result = ChargeBee_Invoice::refund("DemoInv_107",array(
//        "refund_amount" =>120 ,
	"memo" => "just a test"));
    print_r($result);
}

function refundTransaction()
{
    $result = ChargeBee_Transaction::refund("txn_HvQquEiOlOfXntcK",array(
//        "refund_amount" => 12,
	"memo" => "just a test"));
    print_r($result);
}

function createCoupon()
{
    $result = ChargeBee_Coupon::create(array(
        "id" => "test_coupon",
        "name" => "Test Coupon",
        "invoice_name" => "my addon",
	"apply_on" => "each_specified_item",
        "applicable_plans" => "none",
        "applicable_addons" => "specific",
        "addonIds" => array("sms_credits","sms_credits"),
	"discount_type" => "fixed_amount",
        "discount_amount" =>100,
        "duration_type" => "one_time",
	"valid_till" => 1393056276));
    $coupon = $result->coupon();
    print_r($coupon);
    print_r($coupon->planIds());
}

function retriveCoupon()
{
$result = ChargeBee_Coupon::retrieve("early_bird_offer");
$coupon = $result->coupon();
print_r($coupon);
// print_r($coupon->planIds);
// foreach ($coupon->planIds as $val)
//     print_r($val);
}


function testSerialize()
{
		  $before = array(
	      "id" => "sub_KyVq7DNSNM7CSD",
          "prorate" => False,
	      "planId" => "free",
	       "addons" => array(array("id" => "monitor", "quantity" => 2), array("id" => "ssl")),
           "addonIds" => array("addonOne","addonTwo"),
	       "card" => array(
	         "firstName" => "Rajaraman",
	         "lastName" => "Santhanam",
	         "number" => "4111111111111111",
	         "expiryMonth" => "1",
	         "expiryYear" => "2024",
	         "cvv" => "007"));

  print_r (ChargeBee_Util::serialize($before));

}

function createPortalSession() 
{
    $result = ChargeBee_PortalSession::create(array(
      "redirectUrl" => "https://www.chargebee.com/thanks.html", 
      "customer" => array(
        "id" => "future_billing"
      )));
    print_r($result->portalSession());
}

function retrievePortalSession($sessionId)
{
    $result = ChargeBee_PortalSession::retrieve($sessionId);
    print_r($result->portalSession());
}

function logoutPortalSession($sessionId)
{
    $result = ChargeBee_PortalSession::logout($sessionId);
    print_r($result->portalSession());
}
/**
 * You define the functions above and call the ones you would like to test here.
 */
// retrieveSubscription();
// retrieveSubWithScheduledChanges();
// removeScheduledChanges();
// plans();
// createSubscription();
// checkoutExistingSubscription();
// allSubscription();
// updateCard();
// retrieveEvent();
retrievCustomField();
// allEvents();
// reactivateSubscription();
// address();
// webhook();
// schoolpage();
// createSubscriptionWithAddons();
// updateSubscriptionWithAddons();
// createSubscriptionEstimate();
// testDiacritics();
// invoiceTransactions();
// retrieveSubscriptionsForCust();
// deleteCard();
// createForSub();
// listSubForCust();
// createComment();
// listComment();
// delComment();
// delPlan();
// createPlan();
// updPlan();
// retrievePlan();
// delAddon();
// createAddon();
// retrieveAddon();
// updAddon();
// refundInvoice();
// refundTransaction();
// createCoupon();
// retriveCoupon();

// estimateRenewal();
// addChargeAtTermEnd();
// addAddonAtTermEnd();

// testSerialize();
// createInvForCharge();
// createInvForAddon();
// createPortalSession();
// retrievePortalSession('__dev__VzcdKAcdsHqNaKLWuRHiWPEduD2BoPQU3G');
// logoutPortalSession('__dev__s32W2W1OkbWFwIk3vxtNaJSFiJfcylTy');
