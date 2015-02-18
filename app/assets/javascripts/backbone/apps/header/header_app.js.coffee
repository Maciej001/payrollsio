@Payrollsio.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		list: (navs) ->
			new HeaderApp.List.Controller
				region: App.headerRegion
				navs: 	navs

		change: (navs) ->
			console.log "old navs ", @headerNavs.collection
			@headerNavs.collection = navs

	HeaderApp.on "start", (navs) ->
		API.list navs

	


