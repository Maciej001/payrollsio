@Payrollsio.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Nav extends App.Entities.Model

		isDivider: -> @get("divider")

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
				{ name: "Hi, Maciej", 		url: "#", 	icon: "fi fi-torso" }
			]  

	App.reqres.setHandler "nav:entities", ->
		API.getNavs()

