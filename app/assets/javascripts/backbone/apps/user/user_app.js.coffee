@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

		signup: ->
			new UserApp.Signup.Controller 
				region: App.formRegion

	UserApp.on "start", ->
		API.show()

	App.mainBus.on "user:signup", ->
		API.signup()




