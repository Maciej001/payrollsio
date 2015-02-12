@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			formRegion = options.region
			user = App.entitiesBus.request "new:user:entity"

			signupView = @getSignupView user

			App.addBlackOverlay()

			formView = App.mainBus.request "form:wrapper", signupView

			@show formView, region: formRegion

		getSignupView: (user) ->
			new Signup.User
				model: user


