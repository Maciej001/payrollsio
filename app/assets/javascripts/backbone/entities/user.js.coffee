@Payrollsio.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.User extends App.Entities.Model

	class Entities.UsersCollection extends App.Entities.Collection
		model: 	Entities.User

	class Entities.UserRegistration extends App.Entities.Model
		# url: Routes.user_registration_path()
		url: "users.json"
		paramRoot: "user"
		defaults:
			"email": ""
			"password": ""
			"password_confirmation": ""

	class Entities.UserSession extends App.Entities.Model
		url: Routes.user_session_path()

		defaults:
			"email": ""
			"password": ""

	class Entities.UserPasswordRecovery extends App.Entities.Model
		url: Routes.user_password_path()

		defaults: 
			email: ""

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

		newUserRegistration: ->
			new Entities.UserRegistration

		createCurrentUser: (response) ->
			App.currentUser = new Entities.User response
			console.log "nowy user", response
			console.log "zajebisty nowy user", App.currentUser 
			console.log App.currentUser.get("email")

	App.entitiesBus.reply "users:entities", ->
		API.getUsers()

	App.entitiesBus.reply "user:entity", (id) ->
		API.getUser id

	App.entitiesBus.reply "new:user:entity", ->
		API.newUser()

	App.entitiesBus.reply "new:user:registration", ->
		API.newUserRegistration()

	App.entitiesBus.on "create:current:user", (response) ->
		API.createCurrentUser response