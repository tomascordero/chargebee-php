<?php
class ChargeBee_APIError extends Exception
{
	
	private $httpStatusCode;
	
	private $errorNo;
	
	private $jsonObject;

    private $type;

    private $code;
	
    private $param;

	function __construct($httpStatusCode,$jsonObject)
	{
		parent::__construct($respJson['message']);
        $this->jsonObject = $jsonObject;
        $this->type = $jsonObject['type'];
        $this->code = $jsonObject['code'];
        $this->param = $jsonObject['param'];  
        $this->httpStatusCode = $httpStatusCode;  
	}

    public function getHttpStatusCode(){
        return $this->httpStatusCode;
    }
	
    public function getType(){
        return $this->type;
    }

    public function getCode(){
        return $this->code;
    }

    public function getParam(){
        return $this->param;
    }

    /**
     * This function has been deprecated. Use getHttpStatusCode.
     *@deprecated
     */
	public function getHttpCode()
    {
      return $this->httpCode;
    }

    /**
     * This function has been deprecated. There IO errors are now thrown as 
     * ChargeBee_IOException.
     *@deprecated
     */
    public function getErrorNo()
    {
      return 0;
    }

    public function getJsonObject()
    {
      return $this->jsonObject;
    }

}
?>
