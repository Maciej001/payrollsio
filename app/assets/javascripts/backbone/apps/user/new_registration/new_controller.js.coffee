@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			user = App.request "new:user:entity"

			signupView = @getSignupView user

			App.addWhiteOverlay()

			# @show signupView

		getSignupView: (user) ->
			new Signup.User
				model: user


