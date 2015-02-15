# Extending sync event, so we will not display empty forms or views, 
# before data has been fetched

# Backbone.sync is called every time Backbone reads or saves model 
# to the server. It uses jQuery.ajax to make RESTful JSON request 
# and returns jqXHR (jQuery XMLHttpRequest). 
# You can overwrite it to use different persistence strategy, such as
# WebSockets, XML transport, or Local Storage.
# Whenever a model or collection begins a sync with the server, 
# a 'request' event is emitted. If the request completes 
# successfully you'll get a 'sync' event, and an 'error' event if not. 

do (Backbone) ->
	_sync = Backbone.sync

	# method - eg. "read" is returned when 'fetch' method is called
	# entity - is model or collection
	# Object - options passed to sync - success and error callbacks
	Backbone.sync = (method, entity, options = {}) ->

		# Backbone.sync uses jQuery.ajax function so we can use 
		# its beforeSend pre-request callback function to modify object
		# before it is sent. 
		# _.bind binds function to the model, so in the function 'this'
		# will always point to the model in this case 'entity'

		# _.defaults options,
		# 	beforeSend: (xhr) ->
		# 		token = $('meta[name="csrf-token"]').attr('content')
		# 		xhr.setRequestHeader('X-CSRF-Token', token)

		if method isnt "read"
			_.defaults options,
				beforeSend: _.bind(methods.beforeSend, 	entity)
				complete:		_.bind(methods.complete, 		entity) 

		sync = _sync(method, entity, options) # XHR returned

		if !entity._fetch and method is "read"
			entity._fetch = sync

	# beforeSend and complete trigger events serviced by FormWrapper view
	# They add and remove ovelay container that makes form looks like 
	# inactive.
	methods = 
		beforeSend: ->
			# because _.bind was used, '@' means model within the function
			@trigger "sync:start", @ 

		complete: ->
			@trigger "sync:stop", @ 







 





