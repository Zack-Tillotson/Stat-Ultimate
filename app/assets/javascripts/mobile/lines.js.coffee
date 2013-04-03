# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Hide checkboxes so we can replace it with colors!
$(->
  $('.player-box label').click(->
    $(this).parent().toggleClass('color2')
  )
  $('.player-box input').addClass("hide")
  $('#received-label').click(->
    console.log "clicked", $('#line_received')[0].checked
    if $('#line_received')[0].checked
      console.log "changing to received"
      $(this).html("Received")
    else
      console.log "changing to pulled"
      $(this).html("Pulled")
  )
  $('#line_received').addClass("hide")
)
