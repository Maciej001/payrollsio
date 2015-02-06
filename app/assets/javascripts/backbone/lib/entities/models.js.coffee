@PlanetExpress.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.Model extends Backbone.Model

		destroy: (options = {}) ->
			# wait = true: waits    for the server to respond before
			# removing the model from the collection
			_.defaults options,
				wait: true

			# setting _destroy on the model allows us to code nice 
			# implementation for destruction: check views/base/view.js.coffee
			@set _destroy: true

			super options

		isDestroyed: -> 
			@get "_destroy"


		# Override default Backbone save method, setting wait: true
		# We will wait for server before setting the new attributes
		# on the model.
		# Additionally we will fire custom event
		# When model is saved collection can be passed in options
		# so you can then update it.
		save: (data, options = {}) ->
			console.log "Model is being saved with data: ", data
			isNew = @isNew()

			_.defaults options,
				wait: true

				# save method accepts 'success' and 'error' callback functions 
				# in the options hash which will be passed the 
				# arguments(model, response, options).
				# _.bind(function, object, arguments)
				# _.bind binds function to an object and passes arguments
				success: 	_.bind(@saveSuccess, @, isNew, options.collection)
				error:		_.bind(@saveError, @)

			# remove _errors attribute set below in saveError function
			@unset "_errors"

			super data, options


		saveSuccess: (isNew, collection) ->
			# Model will trigger events that will be available for other views
			# and can act upon them
			# Eg.: our edit view should update name of the crew member
			if isNew 
				# add model to the collection
				collection.add @ if collection

				# trigger event on model (@), that informs 
				# about adding model to the collection
				collection.trigger "model:created", @ if collection

				# model is being created
				console.log "event 'created' triggered "
				@trigger "created", @
			else
				# if collection was passed use: collection
				# if not use @collection property that is already on that model
				collection ?= @collection
				collection.trigger "model:updated", @ if collection

				# model is being updated
				@trigger "updated", @

		saveError: (model, xhr, options = {}) ->
			# We are not passing any arguments so it will recieve default 
			# arguments model, response, options
			#
			# set(attributes, [options]) sets hash of attributes on the model
			# "change:_errors" is triggered and we can catch it in FormWrapper
			# view. Instead we could just trigger an event and catch it elsewhere
			@set _errors: xhr.responseJSON?.errors unless xhr.status is 500 or xhr.status is 404

			# don'f forget to unset before next submit of the form. On submit all 
			# error messages should disapear from the form. 


			










