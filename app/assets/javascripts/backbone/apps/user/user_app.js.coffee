@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

		login: ->
			new UserApp.Signin.Controller

		logout: ->
			console.log "logoutujemy"

		signup: ->
			new UserApp.Signup.Controller
				region: App.formRegion

	UserApp.on "start", ->
		API.show()

	App.commands.setHandler "user:signin", ->
		API.login()

	App.commands.setHandler "user:signup", ->
		API.signup()

	App.commands.setHandler "user:logout", ->
		APP.logout()
