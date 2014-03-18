$ ->
	refreshInvites = ->
		url = $("#response").data "url"
		$.get url, (response) ->
			$("#response").html(response)

	$("#rsvp-modal").on "ajax:send", "#add-member-form", (event) ->
		this.reset()

	$("#rsvp-modal").on "ajax:success", "#add-member-form", (event, response) ->
		$("#group-member-list").append(response)
		refreshInvites()

	$("#rsvp-modal").on "ajax:error", "#add-member-form", (event) ->
		$.jGrowl "Name Fields Cannot Be Blank - Please Try Again", { position: "center" }

	$("#rsvp-modal").on "ajax:success", "#delete-member-form", (event) ->
		$tr = $(this).closest "tr"
		$tr.remove()
		refreshInvites()

