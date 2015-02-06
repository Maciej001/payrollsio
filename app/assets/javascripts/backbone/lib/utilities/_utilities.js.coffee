@Payrollsio.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->
	
	App.commands.setHandler "when:fetched", (entities, callback) ->
		# calls the callback function when entities are fetched from server

		xhrs = []

		# chain - enables chaining of functions. It returns wrapped object
		# 				until value() method is called
		# flatten - flattens object and returns flat array
		# pluck - maps array of object extracting only '_fetch' object 
		xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

		$.when(xhrs...).done ->
			callback()