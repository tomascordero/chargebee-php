<?php

require('../ChargeBee.php');

function test($file){
	$fileName = "../../../files/".$file.".json";
	$myFilw = fopen($fileName, "r");
	$respJson = fread($myFilw, filesize($fileName));
	fclose($myfile);
	print_r($respJson);
	array($respJson, '');
	$resp = json_decode($respJson, true);
	$res = new ChargeBee_Result($resp);
	$r = $res->estimate();
	print_r($r);
	// print_r($est->invoiceEstimate);
	// print_r($est->invoiceEstimates[0]->lineItems[0]);
}


test('est');
?>