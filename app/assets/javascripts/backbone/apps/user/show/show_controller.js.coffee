@Payrollsio.module "UserApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Controller extends App.Controllers.Application

		initialize: (options) ->
			@userLayoutView = @getUserLayoutView() 

			@listenTo @userLayoutView, "show", =>
				@userActionsRegion()
				@userStatsRegion()

			@show @userLayoutView

			App.mainBus.on "show:signup:message", =>
				@showSignupMessage()

		getUserLayoutView: ->
			new Show.UserLayout

		userActionsRegion: ->
			actionsView = @getActionsView()
			@show actionsView, region: @userLayoutView.userActionsRegion

		userStatsRegion: ->
			statsView = @getStatsView()
			@show statsView, region: @userLayoutView.userStatsRegion

		showSignupMessage: ->
			name = App.nameFromEmail App.currentUser.get('email')
			capitalizedName = name.capitalizeWord()
			messageModel = new Show.MessageModel
				name: 		capitalizedName
				message: "welcome aboard!"

			messageView = @getMessageView 
				model: messageModel

			region = @userLayoutView.userMessageRegion

			@show messageView, region: region

			# After 10 seconds Message slides up and disappears
			messageView.$el
				.delay(7000)
				.slideUp(300)
				.queue ->
					region.reset()
			false


		getActionsView: ->
			new Show.Actions 

		getStatsView: ->
			new Show.Stats

		getMessageView: (model) ->
			new Show.Message model: model.model

		


	


