###
Shared functions
###

# polling table data
@updateInformes = ->
    if( $('tr.informe').length )
      after = $('tr.informe:eq(0)').attr('data-time')
      $.getScript('/online/informes.js?after=' + after)
      setTimeout(updateInformes, 10000)

@updateTable = (model, plural = model + 's', timing = 10000) ->
  #console.log $( '#' + plural ).length
  #if ( $( '#' + plural ).length )
    $( 'tr.new').fadeIn()
    #setTimeout( updates( model, plural, timing ), timing )
    #delay timing, -> updates( model, plural, timing)
    console.log "hola"

@update = (model, plural, timing) ->
  selector = 'tr.' + model
  script = ( '/online/' + plural + '.js?after=' )
  if ( $( selector ).length )
    after = $( selector + ':eq( 0 )' ).attr( 'data-time' )
    $.getScript( script + after )
    #setTimeout( update( model, plural, timing ), timing)

@updates = (model,plural,timing) ->
  console.log model
  console.log plural
  console.log timing

delay = ( ms, func ) -> setTimeout func, ms