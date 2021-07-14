# UK Royal Mail Click & Drop CFML

Royal Mail Click & Drop CFML provides a wrapper for the Royal Mail UK Click & Drop Web Services.

## Installation
```js
box install RMClickDropCFML
```

## Examples
Check out the `/examples` folder for an example implementation.

## Usage
The UK Royal Mail Click & Drop CFML wrapper consists of two models; one representing the Orders REST API and one able to process the results files provided by the Click & Drop software.
For the moment, the Orders API wrapper is only able to retrieve order data - it does not currently have order creation capabilities.

### Standalone
```cfc
RMOrders = new models.orders(
	api_key = 'your-api-key'
);

RMResultsFiles = new models.fileManager(
	resultsfilePath = 'path/to/folder'
);
```

### ColdBox
```cfc
RMOrders 		= getInstance("orders@RMClickDropCFML");
RMResultsFiles 	= getInstance("fileManager@RMClickDropCFML");
```
alternatively inject it directly into your handler
```cfc
property name="RMOrders" inject="tracking@RMClickDropCFML";
property name="RMResultsFiles" inject="fileManager@RMClickDropCFML";
```

When using with ColdBox, you'll want to insert your API key and/or filesystem details into your module settings:

```cfc
RMClickDropCFML = {
		api_key 		= getSystemSetting("RM_API_KEY", "")
	,	resultsfilePath	= getSystemSetting("RM_RESULTSFILEPATH", "")
}
```

### Get order details
Retrieve details about a click & drop order with a simple call to the retrieve function of the orders model. This will return event dates and a tracking number.

```cfc
orderDetails = RMOrders.retrieve('123456');
```


### Retrieve order result data
When dropping order files into Click & Drop, result files are generated. You may use functions of the fileManager model to retrieve data from these files.

```cfc
fileList = RMResultsFiles.getFileList();
```

During processing, files are copied over to an internal folder for storage. (defaults to `/store`). You may remove files from their original location with the `deleteFiles` argument.

```cfc
fileContents = RMResultsFiles.processFiles(
		dateRange 		= '2021-01-01,2021-01-31'
	,	deleteFiles 	= false
);
```


## Author
Written by Gary Stanton.  
https://garystanton.co.uk