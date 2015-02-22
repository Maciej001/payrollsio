@Payrollsio.module "Components.Form", (Form, App, Backbone, Marionette, $, _) ->

	class Form.Controller extends App.Controllers.Application

		initialize: (options = {}) ->
			@contentView = options.view

			@formLayout = @getFormLayout options.config

			@listenTo @formLayout, "show", @formContentRegion
			@listenTo @formLayout, "form:submit", @formSubmit
			@listenTo @formLayout, "form:cancel", @formCancel

		formCancel: ->
			@contentView.triggerMethod "form:cancel"

		formSubmit: ->
			console.log "debug: formSubmit was triggered."

			data = Backbone.Syphon.serialize @formLayout 

			console.log "debug: Syphone data: ", data

			model = @contentView.model
			collection = @contentView.collection

			console.log "debug: sending for processing: ", data, model, collection
			@processFormSubmit data, model, collection

		processFormSubmit: (data, model, collection) ->
			console.log "debug: model to be saved: ", data, model
			model.save data,  
				collection: collection 

		formContentRegion: ->
			@region = @formLayout.formContentRegion
			@show @contentView 

		getFormLayout: (options = {}) ->
			# _.result(object, property)
			# _.result lets you get a named value from an object
			# without knowing weather that value is stored as 
			# property or a method
			# in below case @contentView.form - can be either 
			# property or a method and we still get an object
			# form { footer: false }
			config = @getDefaultConfig _.result(@contentView, "form")

			# takes config objects, and adds/overrides its properties 
			# with optins object properties.
			# This is so footer:true, can be passed when creating 
			# form wrapper in edit_controller
			_.extend config, options
			buttons = @getButtons config.buttons

			new Form.FormWrapper
				config: config

				# forms require models in all cases no matter what!
				model: @contentView.model 
				buttons: buttons 

		getDefaultConfig: (config = {}) ->
			# _.defaults(object, *defaults) - fills in undefined properties
			# in object with the first value in the following list 
			# of defaults objects
			# If form footer is undefined than it's set to 'true'
			_.defaults config,
				footer: true
				focusFirstInput: true
				errors: true    # on/off switch for errors parsing in form_view
				syncing: true 	# if syncStart and syncStop should be serviced
												# form_view.js.coffee

		getButtons: (buttons = {}) ->
			App.entitiesBus.request("form:button:entities", buttons, @contentView.model) unless buttons is false
	
	App.mainBus.reply "form:wrapper", (contentView, options = {}) ->
		throw new Error "No model found inside of form's contentView" unless contentView.model
		# Controller takes only one argument so we have wrap our 
		# parameters in the object and pass it to controller
		# Since we create new Controller we have to implement
		# initialize function above     

		formController = new Form.Controller
			view: contentView
			config: options

		formController.formLayout 




