@Payrollsio.module "UserApp.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	
	class Signin.Controller extends App.Controllers.Application

		initialize: (options) ->
			App.addBlackOverlay()
			{ region } = options

			user = App.entitiesBus.request "user:signin:entity"
			console.log "debug: got new user entity: ", user

			@view = @getSigninView user

			@listenTo @view, "form:cancel", ->
				App.mainBus.trigger "close:form", @

			@formView = App.mainBus.request "form:wrapper", @view

			@show @formView, region: region


		onBeforeDestroy: ->
			App.removeBlackOverlay()
			@formView.destroy()

		getSigninView: (user) ->
			new Signin.User
				model: user