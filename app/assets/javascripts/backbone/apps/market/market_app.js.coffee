@Payrollsio.module "MarketApp", (MarketApp, App, Backbone, Marionette, $, _) ->
	
	@startWithParent = false

	API = 
		show: ->
			new MarketApp.Show.Controller

		login: ->
			new MarketApp.Signin.Controller

		logout: ->
			console.log "logoutujemy"

		signup: ->
			console.log "nowy userek"

	MarketApp.on "start", ->
		API.show()

	App.commands.setHandler "user:signin", ->
		API.login()


	App.commands.setHandler "user:signup", ->
		API.signup()

	App.commands.setHandler "user:logout", ->
		APP.logout()