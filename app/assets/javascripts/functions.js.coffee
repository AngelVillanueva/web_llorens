$(document).ready ->
  # debug slider (not for production)
  if ($('#debug').size())
    $('#debug').hide()
    $('a.debug').click ->
      $('#debug').slideToggle()
      $('a.debug b').toggleClass('clicked')
      event.stopPropagation()