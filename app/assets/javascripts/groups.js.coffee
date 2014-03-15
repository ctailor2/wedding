$ ->
	toggleLoaderOn = ->
		$("body").modalmanager("loading")
	toggleLoaderOff = ->
		$("body").modalmanager("removeLoading")

	$("#group-finder-form").bind "ajax:send", toggleLoaderOn
	$("#group-finder-form").bind "ajax:success", toggleLoaderOff

	$("#rsvp-modal").on "show.bs.tab", "#response-btn", (event) ->
		$(event.target.previousElementSibling).removeClass "active"
		$(event.target).addClass "active"

	$("#rsvp-modal").on "show.bs.tab", "#members-btn", (event) ->
		$(event.target.nextElementSibling).removeClass "active"
		$(event.target).addClass "active"
