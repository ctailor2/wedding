$ ->
	refreshInvites = ->
		url = $("#response").data "url"
		$.get url, (response) ->
			$("#response").html(response)

	$("#group-finder-form").on "ajax:send", (event) ->
		this.reset()

	$("#group-finder-form").on "ajax:success", (event, response) ->
		$("#rsvp-modal").html(response)
		$("#rsvp-modal").modal()
		refreshInvites()

	$("#group-finder-form").on "ajax:error", (event) ->
		$.jGrowl "Group not found - Please try again", { position: "center" }

	$("#rsvp-modal").on "ajax:success", "#group-rsvp-form", (event) ->
		$("#rsvp-modal").modal("hide")
		$.jGrowl "Thanks for your RSVP - We look forward to celebrating our wedding with you!", { position: "center" }

	$("#rsvp-modal").on "show.bs.tab", "#response-btn", (event) ->
		$(event.target.previousElementSibling).removeClass "active"
		$(event.target).addClass "active"

	$("#rsvp-modal").on "show.bs.tab", "#members-btn", (event) ->
		$(event.target.nextElementSibling).removeClass "active"
		$(event.target).addClass "active"

