@Payrollsio.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.User extends App.Entities.Model
		# we need a route cause it being fetched by itself without going
		# through the collection
		# Backbone knows what to get depending if the request has id or not


	class Entities.UsersCollection extends App.Entities.Collection
		model: 	Entities.User


	API = 
		getUsers: ->
			users = new Entities.UsersCollection
			users.fetch
				reset: true 
			users

		getUser: (id) ->
			user = new Entities.User
				id: id
			member.fetch()
			member

		newUser: ->
			new Entities.User

	App.reqres.setHandler "users:entities", ->
		API.getUsers()

	App.reqres.setHandler "user:entity", (id) ->
		API.getUser id

	App.reqres.setHandler "new:user:entity", ->
		API.newUser()