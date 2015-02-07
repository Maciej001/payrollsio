@Payrollsio.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->
	
	class List.Nav extends App.Views.ItemView 
		tagName:	"li"

		# modelEvents:
		# 	"change:chosen"	: "changeChosen"

		getTemplate: ->
			"header/list/_nav"

	class List.Header extends App.Views.CompositeView	
		template: 					"header/list/header"
		childView:					List.Nav
		childViewContainer:	"#nav-links"