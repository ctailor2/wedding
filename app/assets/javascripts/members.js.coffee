$ ->
  refreshInvites = ->
    url = $("#response").data "url"
    $.get url, (response) ->
      $("#response").html(response)
      $(".invite-group").each (index, inviteGroup) ->
        checkDisabler($(inviteGroup))
        noneDisabler($(inviteGroup))

  inviteGroupVariables = (inviteGroup) ->
    numInvited = inviteGroup.data "invited"
    checkboxes = inviteGroup.find "input:checkbox"
    none = inviteGroup.find ".none"
    checked = checkboxes.filter(".member:checked").length
    unchecked = checkboxes.filter ":not(:checked)"
    [numInvited, checkboxes, none, checked, unchecked]

  checkDisabler = (inviteGroup) ->
    [numInvited, checkboxes, none, checked, unchecked] = inviteGroupVariables(inviteGroup)
    unchecked.prop "disabled", checked >= numInvited or none.is(":checked")

  noneDisabler = (inviteGroup) ->
    [numInvited, checkboxes, none, checked, unchecked] = inviteGroupVariables(inviteGroup)
    none.prop "disabled", checked > 0

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

