@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			user = App.entitiesBus.request "new:user:entity"

			signupView = @getSignupView user

			App.addBlackOverlay()

			@show signupView, region: @formRegion

		getSignupView: (user) ->
			new Signup.User
				model: user


