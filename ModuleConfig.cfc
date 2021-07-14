/**
* This module wraps the UK Royal Mail Click & Drop API
**/
component {

	// Module Properties
    this.modelNamespace			= 'rmclickdrop';
    this.cfmapping				= 'rmclickdrop';
    this.parseParentSettings 	= true;

	/**
	 * Configure
	 */
	function configure(){

		// Skip information vars if the box.json file has been removed
		if( fileExists( modulePath & '/box.json' ) ){
			// Read in our box.json file for so we don't duplicate the information above
			var moduleInfo = deserializeJSON( fileRead( modulePath & '/box.json' ) );

			this.title 				= moduleInfo.name;
			this.author 			= moduleInfo.author;
			this.webURL 			= moduleInfo.repository.URL;
			this.description 		= moduleInfo.shortDescription;
			this.version			= moduleInfo.version;

		}

		// Settings
		settings = {
				'api_key' : ''
			,	'resultsfilePath' : ''
		};
	}

	function onLoad(){
		binder.map( "orders@rmclickdrop" )
			.to( "#moduleMapping#.models.orders" )
			.asSingleton()
			.initWith(
				api_key = settings.api_key
			);

		binder.map( "fileManager@rmclickdrop" )
			.to( "#moduleMapping#.models.fileManager" )
			.asSingleton()
			.initWith(
				resultsfilePath = settings.resultsfilePath
			);

	}

}