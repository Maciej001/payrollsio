@Payrollsio.module "UserApp.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	
	class Signin.Controller extends App.Controllers.Application

		initialize: (options) ->
			App.addBlackOverlay()

			{ @region } = options

			user = App.entitiesBus.request "new:user:signin:entity"

			@signinView = @getSigninView user

			@listenTo @signinView, "form:cancel", ->
				App.mainBus.trigger "close:form", 
					region: @region
					controller: @

			@listenTo @signinView.model, "created",  (model, response) ->
				@signinComplete model, response

			@formView = App.mainBus.request "form:wrapper", @signinView

			@show @formView, region: @region

		onBeforeDestroy: ->
			App.removeBlackOverlay()
			@formView.destroy()

		getSigninView: (user) ->
			new Signin.User
				model: user

		signinComplete: (model, response) ->
			console.log "signin complete", model, response