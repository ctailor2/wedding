$ ->
  $("#rsvp-modal").on "change", "input:checkbox", (event) ->
    inviteGroup = $(this).closest ".invite-group"
    numInvited = inviteGroup.data "invited"
    checkboxes = inviteGroup.find "input:checkbox"
    none = inviteGroup.find ".none"
    checked = checkboxes.filter(".member:checked").length
    unchecked = checkboxes.filter ":not(:checked)"

    unchecked.prop "disabled", checked >= numInvited or none.is(":checked")

  $("#rsvp-modal").on "change", "input:checkbox", (event) ->
    inviteGroup = $(this).closest ".invite-group"
    numInvited = inviteGroup.data "invited"
    checkboxes = inviteGroup.find "input:checkbox"
    none = inviteGroup.find ".none"
    checked = checkboxes.filter(".member:checked").length
    unchecked = checkboxes.filter ":not(:checked)"

    none.prop "disabled", checked > 0

  $("#rsvp-modal").on "shown", (event) ->
    inviteGroups = $(this).find ".invite-group"
    inviteGroups.each (index, inviteGroup) ->
      numInvited = $(inviteGroup).data "invited"
      checkboxes = $(inviteGroup).find "input:checkbox"
      none = $(inviteGroup).find "#none"
      checked = checkboxes.filter(":checked").length
      unchecked = checkboxes.filter ":not(:checked)"

      unchecked.prop "disabled", checked >= numInvited or none.is(":checked")

  $("#rsvp-modal").on "shown", (event) ->
    inviteGroups = $(this).find ".invite-group"
    inviteGroups.each (index, inviteGroup) ->
      numInvited = $(inviteGroup).data "invited"
      checkboxes = $(inviteGroup).find "input:checkbox"
      none = $(inviteGroup).find "#none"
      checked = checkboxes.filter(":checked").length
      unchecked = checkboxes.filter ":not(:checked)"

      none.prop "disabled", checked > 0
