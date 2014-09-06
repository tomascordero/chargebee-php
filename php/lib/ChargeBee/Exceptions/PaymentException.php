<?php
class ChargeBee_PaymentException extends ChargeBee_APIError
{

	function __construct($httpStatusCode,$message,$jsonObject)
	{
		parent::__construct($httpStatusCode,$message,$jsonObject);
    }
}
?>
