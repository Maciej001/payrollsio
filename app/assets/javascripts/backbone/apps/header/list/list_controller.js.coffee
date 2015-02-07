@Payrollsio.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Controller extends App.Controllers.Application

		initialize: (options) ->
			# normally we would put navs = App.request "nav:entities" here
			# but we are moving it one level up to be able to service 
			# click events to header_app 
			{ navs } = options
			console.log "what are navs : ", navs
			listView = @getListView navs
			@show listView

		getListView: (navs) ->
			new List.Header	
				collection: navs