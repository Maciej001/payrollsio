@Payrollsio.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Nav extends App.Entities.Model

		choose: ->
			# sets the attribute on the model. Later you can bind events 
			# change:chosen
			@set chosen: true

		unchoose: ->
			@set chosen: false

		chooseByCollection: ->
			@collection.choose @  


	class Entities.NavsCollection extends App.Entities.Collection
		model: Entities.Nav

		choose: (model) ->
			_(@where chosen: true).invoke("unchoose")
			model.choose()

		chooseByName: (nav) ->
			@choose @findWhere(name: nav)

	API = 
		getNavs: ->
			navs = new Entities.NavsCollection [
				{ name: "Log in", 	id: "login",	url: "#", icon: "fi fi-power" }
				{ name: "Sign up",	id: "signup",	url: "#", icon: "fi fi-skull" }
			]

		getNavsAuthenticated: ->
			navs = new Entities.NavsCollection [
				{ name: "Log in", 	id: "login",	url: "#", icon: "fi fi-power" }
				{ name: "Log out",	id: "singup",	url: "#", icon: "fi fi-skull" }
			]

	App.entitiesBus.reply "nav:entities", ->
		API.getNavs()

	App.entitiesBus.reply "nav:authenticated", ->
		API.getNavsAuthenticated()

