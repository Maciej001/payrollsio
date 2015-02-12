@Payrollsio.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Button extends Entities.Model 
		defaults: 
			# all buttons will have button type, if you want one button
			# to be able to submit form on pressing 'enter' you have to 
			# change buttonType = 'submit', or otherwise browser would
			# use first button on the form and 'click' it even if it were 
			# 'cancel' button
			buttonType: "button"

	class Entities.ButtonsCollection extends Entities.Collection	
		model: Entities.Button

	API = 
		getFormButtons: (buttons, model) ->
			buttons = @getDefaultButtons buttons, model

			array = []
			array.push {
				type:"cancel" 
				className: "button small secondary"
				text: buttons.cancel
			} if buttons.cancel
			array.push {
				type:"primary" 
				className: "button small radius"
				buttonType: "submit"
				text: buttons.primary
			} if buttons.primary

			array.reverse() if buttons.placement is "left"

			buttonCollection = new Entities.ButtonsCollection array 
			buttonCollection.placement = buttons.placement
 
			return buttonCollection


		getDefaultButtons: (buttons, model) ->
			_.defaults buttons,
				primary: 		if model.isNew() then "Create" else "Update"
				cancel:			"Cancel"
				placemenet:	"right"

	App.entitiesBus.reply "form:button:entities", (buttons = {}, model) ->
		console.log buttons, model
		API.getFormButtons buttons, model





