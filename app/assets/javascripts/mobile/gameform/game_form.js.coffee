# Hide the check boxes and change the style as people get checked!
$ ->

  $('.player-box').html("")

  $('#received-label').click((e)->
    if $('#line_received')[0].checked
      $('#received-label').html("Pulled")
      $('#line_received')[0].checked = false
    else
      $('#received-label').html("Received")
      $('#line_received')[0].checked = true
  )

  if $('#line_received')[0].checked
    $('#received-label').html("Received")
  else
    $('#received-label').html("Pulled")

  $('#line_received').addClass("hide")

  $('#player-box-title').click((e)->
    $('.player-box').toggle('fast')
    $('#player-box-title').toggleClass('open')
    $('#player-box-title').toggleClass('close')
  )

  $('.submit-btn').click((e) ->
    $(e.target).find('.spinner').show()

    form = $('#new_line')
    form_values = form.serializeArray()
    score_value = $(e.target)[0].value
    form_values.push({"name": "line[scored]", "value": score_value})

    $.ajax({
      url: form.attr('action')
      data: form_values
      dataType: "JSON"
      type: "POST"
    }).success(->
      $(e.target).find('.spinner').hide()
    )

    (player.clearStats() for player in App.activePlayers.models)
    if score_value is 1
      $('#us-score').html(parseInt($('#us-score').html()) + 1)
    else
      $('#them-score').html(parseInt($('#them-score').html()) + 1)
    App.activePlayersView.render()

    return false
  )
