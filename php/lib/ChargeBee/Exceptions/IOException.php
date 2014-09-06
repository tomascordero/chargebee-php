<?php
class ChargeBee_IOException extends Exception
{
   	private $errorNo;

	function __construct($errorNo, $message)
	{
		parent::__construct($message);
    }
}
?>
