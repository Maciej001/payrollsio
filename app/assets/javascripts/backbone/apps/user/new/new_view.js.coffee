@Payrollsio.module "MarketApp.Signin", (Signin, App, Backbone, Marionette, $, _) ->
	
	class Signin.User extends App.Views.ItemView 
		template: "user/new/signin"