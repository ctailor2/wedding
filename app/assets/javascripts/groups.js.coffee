$ ->
	toggleLoaderOn = ->
		$("body").modalmanager("loading")
	toggleLoaderOff = ->
		$("body").modalmanager("removeLoading")

	$("#group-finder-form").bind "ajax:send", toggleLoaderOn
	$("#group-finder-form").bind "ajax:success", toggleLoaderOff
