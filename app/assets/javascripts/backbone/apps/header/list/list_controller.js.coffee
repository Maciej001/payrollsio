@Payrollsio.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Controller extends App.Controllers.Application

		initialize: (options) ->
			# normally we would put navs = App.request "nav:entities" here
			# but we are moving it one level up to be able to service 
			# click events to header_app 
			{ navs } = options
			@listView = @getListView navs
			@show @listView

			@listenTo @listView, "signup:button:clicked", ->
				@signupUser()

			@listenTo App.mainBus, "rerender:navs", (navs) ->
				@listView.collection.reset navs.toJSON

		signupUser: ->
			App.mainBus.trigger "user:signup"

		getListView: (navs) ->
			new List.Header	
				collection: navs

		App.mainBus.on "user:authenticated", ->
			navs = App.entitiesBus.request "nav:authenticated"
			App.mainBus.trigger "rerender:navs", navs

