<!doctype html>

<cfscript>
	setting requesttimeout="600";

	if (StructKeyExists(URL, 'track') && isNumeric(URL.track)) {
		Form.orderNo = URL.track;
	}

	if (StructKeyExists(Form, 'orderNo') && Len(Form.orderNo)) {
		RMOrders = new models.orders(
			api_key = ''
		);

		orders = RMOrders.retrieve(Form.orderNo);
	}

	if (StructKeyExists(Form, 'fileList')) {
		RMResultsFiles = new models.fileManager(resultsfilePath = '');

		fileList = RMResultsFiles.filterFileList();
	}


	if (StructKeyExists(Form, 'fileContents')) {
		RMResultsFiles = new models.fileManager(resultsfilePath = '');

		fileContents = RMResultsFiles.processFiles(
				deleteFiles 	= false
		);
	}


</cfscript>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<title>Royal Mail UK Click & Drop CFML examples</title>
	</head>

	<body>
		<div class="container">
			<h1>Royal Mail UK Click & Drop CFML examples</h1>
			<hr>

			<div class="row">
				<div class="col-sm-6">
					<div class="mr-4">
						<h2>Retrieve orders</h2>
						<p>Provide order number(s) to retrieve details about an order made through click & drop.</p>
						<form method="POST">
							<div class="input-group">
								<input type="text" required="true" class="form-control" id="orderNo" name="orderNo" aria-describedby="orderNo" placeholder="Enter order number(s)">
								<div class="input-group-append">
									<button type="submit" class="btn btn-primary" type="button" name="action" value="order">Query RM Click & Drop API</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="mr-4">
						<h2>Results files</h2>
						<p>When creating orders via batch files, Click & Drop creates results files. Enter filesystem details in the index.cfm to test the following fuctionality.</p>
						<form method="POST">
							<div class="input-group">
								<div class="">
									<button type="submit" class="btn btn-primary" type="button" name="fileList">View file list</button>
									<button type="submit" class="btn btn-primary" type="button" name="fileContents">View file contents</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

			<cfif structKeyExists(Variables, 'orders')>
				<hr />
				<cfdump var="#orders#">
			</cfif>

			<cfif structKeyExists(Variables, 'fileList')>
				<hr />
				<cfdump var="#fileList#">
			</cfif>

			<cfif structKeyExists(Variables, 'fileContents')>
				<hr />
				<cfif isQuery(fileContents)>
					<table class="table table-compact table-striped">
						<thead>
							<tr>
								<th>Row</th>
								<th>Status</th>
								<th>Message</th>
								<th>Order</th>
								<th>Reference</th>
								<th>Tracking</th>
								<th>Filename</th>
								<th></th>
							</tr>
						</thead>
						<cfoutput>
						<cfloop query="fileContents">
							<tr>
								<td>#fileContents.row#</td>
								<td>#fileContents.Status#</td>
								<td>#fileContents.Message#</td>
								<td>#fileContents.Order_number#</td>
								<td>#fileContents.Order_reference#</td>
								<td>#fileContents.Tracking_number#</td>
								<td>#fileContents.Filename#</td>
								<td>
									<cfif isNumeric(fileContents.Order_number)>
										<a href="?track=#fileContents.Order_number#" class="btn btn-primary btn-sm">Track</a>
									</cfif>
								</td>
							</tr>
						</cfloop>
						</cfoutput>
					</table>
				<cfelse>
					<cfdump var="#fileContents#">
				</cfif>
			</cfif>
		</div>
	</body>
</html>