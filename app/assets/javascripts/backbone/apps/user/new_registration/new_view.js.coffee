@Payrollsio.module "UserApp.Signup", (Signup, App, Backbone, Marionette, $, _) ->
	
	class Signup.User extends App.Views.ItemView 
		template: "user/new_registration/signup"

		triggers: 
			"submit form" : "create:new:user"
