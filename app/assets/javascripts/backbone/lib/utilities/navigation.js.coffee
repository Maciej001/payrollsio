@Payrollsio.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

	_.extend App,

		navigate: (route, options = {}) ->
			# route = "#" + route if route.charAt(0) is "/"
			Backbone.history.navigate route, options

		getCurrentRoute: ->
			frag = Backbone.history.fragment
			if _.isEmpty(frag) then null else frag

		startHistory: ->
			if Backbone.history
				Backbone.history.start()	

		addWhiteOverlay: ->
			docHeight = $(document).height()

			$("body")
				.append("<div id='overlay'></div>")

			$("#overlay")
				.height(docHeight)
				.hide()
				.fadeTo(300, 0.7)
				.css
					'position': 'absolute'
					'top': 0
					'left': 0
					'background-color': 'white'
					'width': '100%'
					'z-index': 5000

			removeWhiteOverlay: ->
				$("#overlay").remove()