@Payrollsio.module "UserApp.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	
	class Signin.Controller extends App.Controllers.Application

		initialize: (options) ->
			App.addBlackOverlay()
			{ region } = options

			user = App.entitiesBus.request "user:signin:entity"
			console.log "debug: got new user entity: ", user

			@view = @getSigninView user

			@formView = App.mainBus.request "form:wrapper", @view

			@show @formView, region: region

		getSigninView: (user) ->
			new Signin.User
				model: user