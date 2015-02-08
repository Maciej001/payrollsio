@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			user = App.request "new:user:entity"

			signupView = @getSignupView user

			@show signupView

			@listenTo signupView, "childview:create:new:user", ->
				console.log "request creating new user"

		getSignupView: (user) ->
			new Signup.User
				model: user