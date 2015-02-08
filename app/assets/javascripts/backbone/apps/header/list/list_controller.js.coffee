@Payrollsio.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Controller extends App.Controllers.Application

		initialize: (options) ->
			# normally we would put navs = App.request "nav:entities" here
			# but we are moving it one level up to be able to service 
			# click events to header_app 
			{ navs } = options
			@listView = @getListView navs
			@show @listView

			@listenTo @listView, "login:button:clicked", ->
				@loginUser()


			@listenTo @listView, "logout:button:clicked", ->
				@logoutUser()

			@listenTo @listView, "signup:button:clicked", ->
				@signupUser()

		loginUser: ->
			App.execute "user:signin"

		logoutUser: ->
			App.execute "user:logout"

		signupUser: ->
			App.execute "user:signup"

		getListView: (navs) ->
			new List.Header	
				collection: navs