@Payrollsio.module "UserApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class Show.User extends App.Views.ItemView
		template: "user/show/user"
