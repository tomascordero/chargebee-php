<?php

require('../../php/lib/ChargeBee.php');

function toResult($f){
	$fileName = "../../files/".$f.".json";
	$myFile = fopen($fileName, "r");
	$respJson = fread($myFile, filesize($fileName));
	fclose($myFile);
	// print_r($respJson);
	array($respJson, '');
	$resp = json_decode($respJson, true);
	$result = new ChargeBee_Result($resp);
	return $result;
}


function printEstimate($result){
	echo "RESULT\n";	
	print_r($result);
	
	echo "ESTIMATE\n";
	print_r($result->estimate());	
	
	echo "INVOICE_ESTIMATE\n";
	print_r($result->estimate()->invoiceEstimate);

	echo "INVOICE_ESTIMATE_LINE_ITEM\n";
	print_r($result->estimate()->invoiceEstimate->lineItems[0]);

	echo "INVOICE_ESTIMATE_LINE_ITEM.UNIT_PRICE\n";
	print_r($result->estimate()->invoiceEstimate->lineItems[0]->unitAmount);

	echo "CREDIT_NOTE_ESTIMATE\n";
	print_r($result->estimate()->creditNoteEstimates[0]);

	echo "CREDIT_NOTE_ESTIMATE\n";
	print_r($result->estimate()->creditNoteEstimates[1]);

	echo "CREDIT_NOTE_ESTIMATE_LINE_ITEM\n";
	print_r($result->estimate()->creditNoteEstimates[0]->lineItems[0]);
	
	echo "CREDIT_NOTE_ESTIMATE_DISCOUNT\n";
	print_r($result->estimate()->creditNoteEstimates[0]->discounts[0]);
	
	echo "CREDIT_NOTE_ESTIMATE_TAX\n";
	print_r($result->estimate()->creditNoteEstimates[0]->taxes[0]);

	echo "CREDIT_NOTE_ESTIMATE_DISCOUNT.AMOUNT\n";
	print_r($result->estimate()->creditNoteEstimates[0]->discounts[0]->amount);
		
}

function printCreditNotes($result){
	echo "RESULT\n";	
	print_r($result);
	
	echo "CREDITNOTES\n";
	print_r($result->creditNotes[0]));	
	
	
}	

function test($file){
	$result = toResult($file);
	// printEstimate($result);
	printCreditNotes($result);
}



// test('estimate');
test('upd_sub.json');

?>