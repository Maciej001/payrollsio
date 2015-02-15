@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			formRegion = options.region
			user = App.entitiesBus.request "new:user:registration"
			console.info "new user: ", user.url

			@signupView = @getSignupView user

			@listenTo @signupView, "form:cancel", ->
				App.mainBus.trigger "signup:cancel"

			@listenTo @signupView, "form:submit", (data) ->


			@formView = App.mainBus.request "form:wrapper", @signupView

			@show @formView, region: formRegion

		getSignupView: (user) ->
			new Signup.User
				model: user

		onBeforeDestroy: ->
			@formView.destroy()



