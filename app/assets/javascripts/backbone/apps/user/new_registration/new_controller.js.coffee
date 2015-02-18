@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.Controller extends App.Controllers.Application

		initialize: (options) ->
			App.addBlackOverlay()

			{ region } = options
			user = App.entitiesBus.request "new:user:registration"

			@signupView = @getSignupView user

			@listenTo @signupView, "form:cancel", ->
				App.mainBus.trigger "signup:close:form"

			@listenTo @signupView.model, "created",  (model, response) ->
				@signupComplete model, response

			@formView = App.mainBus.request "form:wrapper", @signupView

			@show @formView, region: region

		getSignupView: (user) ->
			new Signup.User
				model: user

		onBeforeDestroy: ->
			App.removeBlackOverlay()
			@formView.destroy()

		signupComplete: (model, response) ->
			App.entitiesBus.trigger "create:current:user", response

			App.mainBus.trigger "user:authenticated"

			$(@formView.el).fadeOut 50, ->
				App.mainBus.trigger "signup:close:form"

			App.mainBus.trigger "show:signup:message"







