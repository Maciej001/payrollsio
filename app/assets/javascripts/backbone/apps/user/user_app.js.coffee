@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

		signup: ->
			App.addBlackOverlay()
			@signupController = new UserApp.Signup.Controller 
				region: App.formRegion

		signupCancel: ->
			App.removeBlackOverlay()
			@signupController.destroy()

	UserApp.on "start", ->
		API.show()

	App.mainBus.on "user:signup", ->
		API.signup()

	App.mainBus.on "signup:cancel", ->
		API.signupCancel()





