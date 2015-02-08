@Payrollsio.module "UserApp.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	
	class Signin.Controller extends App.Controllers.Application

		initialize: (options) ->
			signinView = @getSigninView() 

			@show signinView

		getSigninView: ->
			new Signin.User