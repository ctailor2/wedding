$ ->
	$("#group-finder-form").on "ajax:send", (event) ->
		this.reset()

	$("#group-finder-form").on "ajax:success", (event, response) ->
		$("#rsvp-modal").html(response)
		$("#rsvp-modal").modal()

	$("#group-finder-form").on "ajax:error", (event) ->
		$.jGrowl "Group Not Found - Please Try Again", { position: "center" }

	$("#rsvp-modal").on "show.bs.tab", "#response-btn", (event) ->
		$(event.target.previousElementSibling).removeClass "active"
		$(event.target).addClass "active"

	$("#rsvp-modal").on "show.bs.tab", "#members-btn", (event) ->
		$(event.target.nextElementSibling).removeClass "active"
		$(event.target).addClass "active"

