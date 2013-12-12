$(document).ready -> 

  # cookie policy check
  checkdCookiesPolicyCookie();

  # set cookie policy if any link is clicked and hide the warning #
  $( document ).on 'click', 'a:not(.nocookie)', ->
    setCookiePolicyOnAction("click")

  # set cookie policy if any submit button is clicked and hide the warning #
  $( document ).on 'click', 'input[type="submit"]', ->
    setCookiePolicyOnAction("click")

  # set cookie policy if scroll and hide the warning #
  $( window ).scroll ->
    unless $('#cookie_policy_page').length
      setCookiePolicyOnAction("scroll") unless $('#legal_page').length

  # close cookie warning on close button click
  $('#cerrar_cookie_warning').click ->
    setCookiePolicyOnAction("click")
    $('#d-policy-disclaimer').hide()
    return false
  
  #tooltip init
  $('a[rel*="tooltip"]').tooltip({ 'placement': 'top' })

  #popover init
  $('a[data-toggle*="popover"]').popover({ 'placement': 'top' })

  #modal alert init
  if ( $( '.modal' ) ).length
    $( '#aviso1' ).modal( 'show' )

  # change text on big buttons (hover)
  $( 'li.new a span' ).hover(
    -> $( this ).html( "+" )
    -> $( this ).html( $( this ).attr('class').split(' ')[0] )
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
      [],
      [
        null,
        null,
        null,
        null,
        null,
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null
        ],
      "Matriculaciones_Llorens",
      [0,1,2,3,4,5,6,7], 
      [
        { type: "select" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "select", values: [ 'PDF Pendiente', 'Ver PDF' ] }
      ]
    )
    $('tr.filter:first').hide()

  # transferencias
  if ( $( '#expedientes.transferencia' ).length )
    createDataTable(
      'expedientes',
      [],
      [
        null,
        null,
        null,
        null,
        null,
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null,
        null
        ],
      "Transferencias_Llorens",
      [0,1,2,3,4,5,6,7,8], 
      [
        { type: "select" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "select" },
        { type: "select", values: [ 'PDF Pendiente', 'Ver PDF' ] }
      ]
    )
    $('tr.filter:first').hide()
  
  # justificantes
  if ( $( '#justificantes' ).length )
    createDataTable(
      'justificantes',
      [],
      [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null,
        null,
        null,
        null
        ],
      "Justificantes_Llorens",
      [0,1,2,3,4,5,6,10,11,14], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        null,
        null,
        null,
        { type: "select" },
        { type: "text" },
        null,
        { type: "date-range" },
        { type: "date-range" },
        null,
        null,
        null,
        null
      ]
    )
    $('tr.filter:first').hide()
    setTimeout(updateJustificantesNewVersion, 5000) # fired polling for new records
  
  # informes
  if ( $( '#informes' ).length )
    createDataTable(
      'informes',
      [],
      [
        null,
        null,
        null,
        {"sType": "uniDate"},
        null,
        null,
        null,
        null,
        null
        ],
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
    $('tr.filter:first').hide()
    setTimeout(updateInformesNewVersion, 5000) # fired polling for new records

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

  # checkbox "acompany?" for new Justificante
  $( document ).on 'change', '#imacompany', ->
    handleNewJustificanteApellidos()

  # take care of mandatory first name field for new Justificantes via javascript
  $( document ).on 'submit', '#new_justificante', ->
    handleFirstNameIfNotACompany()

  # IE8- rounded borders through PIE.js
  if window.PIE
    $(".pie").each ->
      PIE.attach this