@Payrollsio.module "UserApp", (UserApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API = 
		show: ->
			new UserApp.Show.Controller
				region: App.userRegion

	UserApp.on "start", ->
		API.show()