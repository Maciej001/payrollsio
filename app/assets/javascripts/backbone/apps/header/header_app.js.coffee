@Payrollsio.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		list: (navs) ->
			new HeaderApp.List.Controller
				region: App.headerRegion
				navs: 	navs

	HeaderApp.on "start", (navs) ->
		API.list navs

	App.mainBus.on "user:authenticated", ->
		App.navs = App.entitiesBus.request "nav:authenticated"
		console.log "tu", App.navs

