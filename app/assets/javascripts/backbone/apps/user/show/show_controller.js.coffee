@Payrollsio.module "UserApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Controller extends App.Controllers.Application

		initialize: (options) ->
			@userLayoutView = @getUserLayoutView() 

			@listenTo @userLayoutView, "show", =>
				@userActionsRegion()
				@userStatsRegion()

			@show @userLayoutView

		getUserLayoutView: ->
			new Show.UserLayout

		userActionsRegion: ->
			actionsView = @getActionsView()
			@show actionsView, region: @userLayoutView.userActionsRegion

		userStatsRegion: ->
			statsView = @getStatsView()
			@show statsView, region: @userLayoutView.userStatsRegion

		getActionsView: ->
			new Show.Actions 

		getStatsView: ->
			new Show.Stats