<?php
require('../../php/lib/ChargeBee.php');
ChargeBee_Environment::$scheme = "http";
ChargeBee_Environment::$chargebeeDomain = "localcb.in:8080";
ChargeBee_Environment::configure("mannar-test", "test___dev__lo2w917cu5a6GxS3K4HfPFBM1zYP3URYc");

function createPlan()
{
  $i = 0;
  $res = ChargeBee_Event::all(array(
  "startTime" => 1463616000, 
  "endTime" => 1463786439, 
  "eventType" => "subscription_created",
  "sortBy[asc]" => "occurred_at"));
foreach($res as $entry){
  $i = $i + 1;
  print_r($entry->event()->id."\n");
}
print_r($i);
}

createPlan();