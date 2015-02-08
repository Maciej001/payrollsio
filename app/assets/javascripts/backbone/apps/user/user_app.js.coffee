@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

		signup: ->
			new UserApp.Signup.Controller 

	UserApp.on "start", ->
		API.show()

	App.vent.on "user:signup", ->
		API.signup()




