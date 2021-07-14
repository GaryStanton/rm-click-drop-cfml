/**
 * Name: UK Royal Mail Click & Drop Orders API
 * Author: Gary Stanton (@SimianE)
 * Description: Wrapper for the UK Royal Mail Click & Drop Orders API.
 */
component singleton accessors="true" {

	property name="api_key" type="string";
	property name="api_url" type="string" default="https://api.parcel.royalmail.com/api/v1/";


	/**
	 * Constructor
	 *
	 * @username Your API username
	 * @password Your API password
	 */
	public orders function init(
		required string api_key
	){
		setApi_key(Arguments.api_key);
		return this;
	}


	/**
	 * Retrieve orders
	 *
	 * @orderIdentifiers Order Identifier or several Order Identifiers separated by semicolon
	 * @docs https://api.parcel.royalmail.com/#operation/GetOrdersAsync
	 */
	public function retrieve(
			required string trackingNumbers
	){

        return makeRequest(
                endpoint    = 'orders/' & Arguments.trackingNumbers
            ,	method 		= 'GET'
        );
	}


    /**
     * Makes a request to the API. Will return the content from the cfhttp request.
     * @endpoint The request endpoint
     * @body The body of the request
     */
    private function makeRequest(
            required string endpoint
        ,	string method = 'GET'
        ,   struct body
    ){

        var requestURL  = getApi_url() & Arguments.endpoint;
        var result      = {};

        cfhttp(
            method  = Arguments.method,
            charset = "utf-8",
            url     = requestURL,
            result  = "result"
        ) {
            cfhttpparam(type="header", name="Authorization", value="Bearer #getApi_key()#");
            cfhttpparam(type="header", name="Content-Type", value="application/json");
            if (StructKeyExists(Arguments, 'body')) {
            	cfhttpparam(type="body", value="#SerializeJSON(Arguments.body)#");
            }
        }

        if (StructKeyExists(result, 'fileContent') && isJSON(result.fileContent)) {
            return deserializeJSON(result.fileContent);
        }
        else {
            return {errors: 'Unable to parse JSON result'}
        }
    }
}