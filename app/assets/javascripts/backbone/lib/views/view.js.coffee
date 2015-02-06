@PlanetExpress.module "Views", (Views, App, Backbone, Marionette, $, _) ->

	_destroy = Marionette.View::destroy
	_.extend Marionette.View::,

		# default value is true
		# toggleWrapper has to be available anywhere so add it to 
		# config/jquery.js.coffee
		addOpacityWrapper: (init = true) ->
			@$el.toggleWrapper
				className: "form-opacity"
			, init

		setInstancePropertiesFor: (args...) ->
			# _.pick returns a copy of the object filtered to only have
			# values for the whitelisted args...
			# _.pick({name: 'moe', age: 50, userid: 'moe1'}, 'name', 'age')
			# => {name: 'moe', age: 50
			# @options is available within view as it is and object passed
			# when initializing view
			# if you pass arguments: "config", "buttons" then
			# @config and @buttons will be available in the View
			for key, val of _.pick(@options, args...)
				@[key] = val

		destroy: (args...) ->
			# When destroy() method is called on crew member, we can nicely 
			# remove the view using _destroy arg on model - entities/_base/models.js.coffee
			
			if @model?.isDestroyed()
				wrapper = @$el.toggleWrapper
					className: "opacity"
					backgroundColor: "red"

				wrapper.fadeOut 400, ->
					$(@).remove()

				# => used so this points still to CrewMember view
				@$el.fadeOut 400, =>
					_destroy.apply @, args

			else
				_destroy.apply @, args

		templateHelpers: ->

			linkTo: (name, url, options = {}) ->
				# _.defaults - fills in 'external' option if is not defined with the value of 'false'
				_.defaults options,
					external: false

				url = "#" + url unless options.external 

				"<a href='#{url}>#{@escape(name)}</a>"











