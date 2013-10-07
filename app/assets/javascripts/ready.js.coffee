$(document).ready -> 

  # cookie policy check
  # checkdCookiesPolicyCookie();

  # set cookie policy if any link is clicked and hide the warning #
  # $( document ).on 'click', 'a:not(.nocookie)', ->
  #   setCookiePolicyOnAction("click")

  # set cookie policy if any submit button is clicked and hide the warning #
  # $( document ).on 'click', 'input[type="submit"]', ->
  #   setCookiePolicyOnAction("click")

  # set cookie policy if scroll and hide the warning #
  # $( window ).scroll ->
  #   setCookiePolicyOnAction("scroll") unless $('#legal_page').length

  # close cookie warning on close button click
  # $('#cerrar_cookie_warning').click ->
  #   setCookiePolicyOnAction("click")
  #   $('#d-policy-disclaimer').hide()
  #   return false
  
  #tooltip init
  $('a[rel*="tooltip"]').tooltip({ 'placement': 'top' })

  # change text on big buttons (hover)
  $( 'li.new a span' ).hover(
    -> $( this ).html( "+" )
    -> $( this ).html( $( this ).attr('class') )
  )

  # printThis binding
  $( 'a.print' ).click ->
    $( $(this).attr( 'data-print-area' ) ).printThis()

  $( 'a.printLink').click ->
    printRow( $( this ).parent('td').parent('tr') )

  # prepare the content if a table
  if ( $( 'table' ).length )
    configureDatePicker() # datepicker localization (es)
    configureTableTools() # set the tabletools classes to something Bootstrap-like
    createSearchBox() # custom search box for dataTables functionality

  ###
  dataTables initialization
  ###
  # matriculaciones
  if ( $( '#expedientes.matriculacion' ).length )
    createDataTable(
      'expedientes',
      "Matriculaciones_Llorens",
      [0,1,2,3,4,5,6,7,8,9], 
      [
        { type: "select" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "select" },
        null,
        null
      ]
    )
    $('tr.filter:first').slideUp("slow")

  # transferencias
  if ( $( '#expedientes.transferencia' ).length )
    createDataTable(
      'expedientes',
      "Transferencias_Llorens",
      [0,1,2,3,4,5,6,7,8,9], 
      [
        { type: "select" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "select" },
        null,
        null
      ]
    )
    $('tr.filter:first').slideUp("slow")
  
  # justificantes
  if ( $( '#justificantes' ).length )
    createDataTable(
      'justificantes',
      "Justificantes_Llorens",
      [0,1,2,3,4,5,6,7,8,10,11], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "text" },
        null,
        { type: "date-range" },
        { type: "date-range" },
        null,
        null
      ]
    )
    $('tr.filter:first').slideUp("slow")
    $( '.new' ).fadeIn(); # reveal new records
    setTimeout(updateJustificantes, 10000) # fired polling for new records
  
  # informes
  if ( $( '#informes' ).length )
    createDataTable(
      'informes',
      "Informes_Llorens",
      [0,1,2,3,5], 
      [
        { type: "select" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        null,
        { type: "select" },
        null,
        null,
        null
      ]
    )
    $('tr.filter:first').slideUp("slow")
    $( '.new' ).fadeIn(); # reveal new records
    setTimeout(updateInformes, 10000) # fired polling for new records

  # search link in Tools div
  $( 'a.search' ).click ->
    $( '.dataTables_filter' ).slideToggle()
    false

  # move 'Export to Excel' functionality
  if TableTools.fnGetMasters().length
    moveExportExcelButton()

  # printThis binding
  $( 'a.filtering' ).click ->
    $( 'tr.filter' ).slideToggle()