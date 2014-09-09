<?php
class ChargeBee_OperationFailedException extends ChargeBee_APIError
{
	function __construct($httpStatusCode,$message,$jsonObject)
	{
		parent::__construct($httpStatusCode,$message,$jsonObject);
    }
}
?>
