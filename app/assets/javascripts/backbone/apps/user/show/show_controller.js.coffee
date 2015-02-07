@Payrollsio.module "UserApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Controller extends App.Controllers.Application

		initialize: (options) ->
			showView = @getShowView() 
			@show showView

		getShowView: ->
			new Show.User