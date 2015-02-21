@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

		signup: ->
			@signupController = new UserApp.Signup.Controller 
				region: App.formRegion

		signin: ->
			console.log "debug: creating signin Controller"
			@signinController = new UserApp.Signin.Controller
				region: App.formRegion

		closeForm: (controller) ->
			controller.destroy()

	UserApp.on "start", ->
		API.show()

	App.mainBus.on "user:signup", ->
		API.signup()

	App.mainBus.on "user:signin", ->
		API.signin()

	App.mainBus.on "close:form", (controller) ->
		API.closeForm controller

	





