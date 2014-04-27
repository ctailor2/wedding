$ ->
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

  $("#rsvp-modal").on "change", "input:checkbox", (event) ->
    inviteGroup = $(this).closest ".invite-group"
    checkDisabler(inviteGroup)
    noneDisabler(inviteGroup)

  $("#rsvp-modal").on "shown", (event) ->
    inviteGroups = $(this).find ".invite-group"
    inviteGroups.each (index, inviteGroup) ->
      checkDisabler($(inviteGroup))
      noneDisabler($(inviteGroup))

