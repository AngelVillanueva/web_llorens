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

  # popover binding
  popOverSettings =
    trigger: 'hover',
    container: 'body',
    html: true,
    selector: 'a.incidencia'
      

  $('body').popover(popOverSettings)

  #modal alert init
  if ( $( '.modalAviso' ) ).length
    $( '.modalAviso' ).first().modal( 'show' )
  #new Avisos auto pulled every time defined in new_avisos_pulltime helper
  if ( pulltime = $( '.about_page[data-pulltime]' ) ).length
    setInterval(
      getAvisos
      pulltime.data("pulltime")
    )
  #bind mark an Aviso as shown and seen to the closing button of the Aviso warning
  $('body').on 'click', '.barebones_aviso button.close', ->
    aviso_id = $(this).parent('div').parent('div').attr('id').substring(2)
    changeAvisoStatus( aviso_id, "true" ) # mark Aviso as Shown
    markAvisoAsSeen( aviso_id, not_seen_avisos ) # mark Aviso as Seen
  #bind mark an Aviso as seen to the closing button of the Aviso modal
  # $('body').on 'click', '.modalAviso button.close', ->
  #   aviso_id = $(this).parent('div').parent('div').attr('id').substring(5)
  #   markAvisoAsSeen( aviso_id, not_seen_avisos ) # mark Aviso as Seen

  # change text on big buttons (hover)
  $( 'li.new a span' ).hover(
    -> $( this ).html( "+" )
    -> $( this ).html( $( this ).attr('class').split(' ')[0] )
  )

  # jqClock initialisation for https://github.com/Lwangaman/jQuery-Clock-Plugin
  serverTime = new Date( $( '.tools' ).attr( 'data-jcstart' ) * 1000 )
  $("div#clock").clock(
      { 
        "calendar": "false",
        "langSet":"es",
        "timestamp": serverTime
      }
    )

  # printThis binding
  $( 'a.print' ).click ->
    $( $(this).attr( 'data-print-area' ) ).printThis()

  $( 'a.printLink').click ->
    printRow( $( this ).parent('td').parent('tr') )

  $( 'a.printLinkM').click ->
    printRowM( $( this ).parent('td').parent('tr') )

  $('body').on 'click','a.printLink', ->
    printRow( $( this ).parent('td').parent('tr') )

  $('body').on 'click','a.printLinkM', ->
    printRowM( $( this ).parent('td').parent('tr'), $( this ) )

  # prepare the content if a table
  if ( $( 'table' ).length )
    configureDatePicker() # datepicker localization (es)
    configureTableTools() # set the tabletools classes to something Bootstrap-like
    createSearchBox() # custom search box for dataTables functionality

  ###
  dataTables initialization
  ###
  # stock vehicles (not remote and disabled due to remote version)
  # if ( $( '#stock_vehicles' ).length )
  #   createSimpleDataTable(
  #     'stock_vehicles',
  #     [],
  #     [
  #       { type: "text" },
  #       { type: "select", values: ['En venta', 'Vendido'] },
  #       { type: "select", values: ['Si', 'No'] },
  #       { type: "select", values: ['Si', 'No'] },
  #       { type: "select", values: ['Si', 'No'] },
  #       { type: "select", values: ['Si', 'No'] },
  #       { type: "select", values: ['Si', 'No'] },
  #       null
  #       ]
  #     )
  # matriculaciones
  if ( $( '#expedientes.matriculacion' ).length )
    createRemoteDataTable(
      'expedientes',
      [],
      [
        null,
        null,
        {"sType": "uniDate"},
        null,
        null,
        null,
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null,
        null
        ],
      "Matriculaciones_Llorens",
      [0,1,2,3,4,5,6,7,8,9], 
      [
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "text" },
        { type: "select", values: [ 'PDF Pendiente', 'Ver PDF' ] }
      ],
      [2,6,7]
    )

  # transferencias
  if ( $( '#expedientes.transferencia' ).length )
    createRemoteDataTable(
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
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "date-range" },
        null,
        { type: "select", values: [ 'PDF Pendiente', 'Ver PDF' ] }
      ],
      [5,6]
    )
  
  # justificantes
  if ( $( '#justificantes' ).length )
    createRemoteJustificantesDataTable(
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
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null,
        null,
        null,
        null
        ],
      "Justificantes_Llorens",
      [0,1,2,3,4,5,6,10,11,12], 
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
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "date-range" },
        null,
        null,
        null,
        null
      ],
      []
    )
    setTimeout(updateJustificantesNewVersion, 5000) # fired polling for new records
  
  # mandatos
  if ( $( '#mandatos' ).length )
    createRemoteMandatosDataTable(
      'mandatos',
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
        {"sType": "uniDate"},
        {"sType": "uniDate"},
        null,
        null,
        null,
        null,
        null
        ],
      "Mandatos_Llorens",
      [0,1,2,3,4,5,8,9,10,13], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        null,
        null,
        null,
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "date-range" },
        null,
        null,
        null,
        null,
        null
      ],
      []
    )
    setTimeout(updateMandatosNewVersion, 5000) # fired polling for new records

  # informes
  if ( $( '#informes' ).length )
    createRemoteInformesDataTable(
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
        null
        ],
      "Informes_Llorens",
      [0,1,2,3,5], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "select", values: [ 'Finalizado', 'En curso' ] },
        null,
        null,
        null
      ],
      [3]
    )
    setTimeout(updateInformesNewVersion, 5000) # fired polling for new records

  # documentos
  if ( $( '#documentos' ).length )
    createRemoteDocumentosDataTable(
      'documentos',
      [],
      [
        null,
        null,
        null,
        {"sType": "uniDate"},
        null,
        {"sType": "uniDate"},
        null,
        null,
        null,
        null,
        null
        ],
      "Documentos_Llorens",
      [0,1,2,3,4,5,6,7,8,9,10], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        null,
        { type: "date-range" },
        null,
        null,
        null,
        null,
        null
      ],
      [3,5]
    )
    setTimeout(updateDocumentosNewVersion, 5000) # fired polling for new records

  # drivers
  if ( $( '#drivers' ).length )
    createRemoteDriversDataTable(
      'drivers',
      [],
      [
        null,
        null,
        {"sType": "uniDate"},
        null,
        {"sType": "uniDate"},
        null,
        null,
        null,
        null,
        null,
        null
        ],
      "Drivers_Llorens",
      [0,1,2,3,4,5,6,7,8,9], 
      [
        { type: "text" },
        { type: "text" },
        { type: "date-range" },
        { type: "select", values: [ 'Si', 'No' ] },
        { type: "date-range" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        null,
        null
      ],
      [2,4]
    )
    setTimeout(updateDriversNewVersion, 5000) # fired polling for new records

  # stock_vehicles (remote version)
  if ( $( '#stock_vehicles' ).length )
    createRemoteVehiclesDataTable(
      'stock_vehicles',
      [],
      [
        { type: "text" },
        { type: "select", values: ['En venta', 'Vendido'] },
        { type: "select", values: ['Si', 'No'] },
        { type: "select", values: ['Si', 'No'] },
        { type: "select", values: ['Si', 'No'] },
        { type: "select", values: ['Si', 'No'] },
        { type: "select", values: ['Si', 'No'] },
        null
        ]
      )

  # search link in Tools div
  $( 'a.search' ).click ->
    $( '.dataTables_filter' ).slideToggle()
    false

  # move 'Export to Excel' functionality
  if TableTools.fnGetMasters().length
    moveExportButton()

  # printThis binding
  $( 'a.filtering' ).click ->
    $( 'tr.filter' ).slideToggle()

  # checkbox "acompany?" for new Justificante
  $( document ).on 'change', '#imacompany', ->
    handleNewJustificanteApellidos()

  # representante data hidden default for Mandato (check imacompany)
  if !($( 'input[name=imacompany]').prop("checked"))
    $( 'div.mandato_repre_nombre, div.mandato_repre_apellido_1, div.mandato_repre_apellido_2, div.mandato_nif_representante').hide();
  else
    $( 'div.mandato_primer_apellido, div.mandato_segundo_apellido').hide();

  # checkbox "acompany?" for new Mandato
  $( document ).on 'change', '#imacompany', ->
    cleanNewMandatoFisico()
    handleNewMandatoApellidos()
    handleNewMandatoRepresentante()
    checkImacompanyMandato()


  # representante data hidden default for Mandato (check imanuevo)
  if !($( 'input[name=imanuevo]').prop("checked"))
    $( 'div.mandato_matricula_bastidor label').html("* Matrícula");
  else
    $( 'div.mandato_matricula_bastidor label').hide("* Bastidor");

  # checkbox "anuevo?" for new Mandato
  $( document ).on 'change', '#imanuevo', ->
    cleanNewMandatoVehiculoNuevo()
    handleNewMandatoNewVehicle()
    checkImanuevoMandato()

  # take care of mandatory first name field for new Justificantes via javascript
  $( document ).on 'submit', '#new_justificante', ->
    handleFirstNameIfNotACompanyJustificante()


  # take care of mandatory first name field for new Documento via javascript
  $( document ).on 'submit', '.documentos', ->
    handleBastidorIfANewDocumento()

  # take care of mandatory first name field for new Mandatos via javascript
  $( document ).on 'submit', '#new_mandato', ->
    handleFirstNameIfNotACompanyMandato()

  # take care of mandatory representante data fields for new Mandatos via javascript
  $( document ).on 'submit', '#new_mandato', ->
    handleRepresentanteIfACompanyMandato()

  # take care of mandatory bastidor length field for new Mandatos via javascript
  $( document ).on 'submit', '#new_mandato', ->
    handleBastidorIfANewVehicleMandato()

  # Callback for rendering via JSON (versión remote dataTables, using 'on' to bind also dinamically created links)
  $("#stock_vehicles").on 'ajax:complete', 'a.vehicle[data-type=json]', (event, data, status, xhr) ->
    $( '#modalVehicle .modal-header h3' ).html( "Vehículo matrícula" + " " + data.responseJSON.matricula )
    $( '#modalVehicle .modal-body .pmatricula span' ).html( data.responseJSON.matricula )
    $( '#modalVehicle .modal-body .pparticular span' ).html( formatBooleano( data.responseJSON.compra_venta ) )
    $( '#modalVehicle .modal-body .pcomprav span' ).html( formatBooleano( data.responseJSON.compra_venta ) )
    $( '#modalVehicle .modal-body .pmarca span' ).html( data.responseJSON.marca )
    $( '#modalVehicle .modal-body .pmodelo span' ).html( data.responseJSON.modelo )
    $( '#modalVehicle .modal-body .pcomprador span' ).html( data.responseJSON.comprador )
    $( '#modalVehicle .modal-body .pft span' ).html( formatBooleano( data.responseJSON.ft ) )
    $( '#modalVehicle .modal-body .ppc span' ).html( formatBooleano( data.responseJSON.pc ) )
    $( '#modalVehicle .modal-body .pitv span' ).html( fechaLocal( data.responseJSON.fecha_itv ) )
    $( '#modalVehicle .modal-body .pincidencia span' ).html( data.responseJSON.incidencia )
    $( '#modalVehicle .modal-body .pfec span' ).html( fechaLocal( data.responseJSON.fecha_expediente_completo ) )
    $( '#modalVehicle .modal-body .pfde span' ).html( fechaLocal( data.responseJSON.fecha_documentacion_enviada ) )
    $( '#modalVehicle .modal-body .pfnc span' ).html( fechaLocal( data.responseJSON.fecha_notificado_cliente ) )
    $( '#modalVehicle .modal-body .pfdr span' ).html( fechaLocal( data.responseJSON.fecha_documentacion_recibida ) )
    $( '#modalVehicle .modal-body .pfeg span' ).html( fechaLocal( data.responseJSON.fecha_envio_gestoria ) )
    $( '#modalVehicle .modal-body .pbajae span' ).html( data.responseJSON.baja_exportacion )
    $( '#modalVehicle .modal-body .pfed span' ).html( fechaLocal( data.responseJSON.fecha_entregado_david ) )
    $( '#modalVehicle .modal-body .pfedf span' ).html( fechaLocal( data.responseJSON.fecha_envio_definitiva ) )
    $( '#modalVehicle .modal-body .pobservaciones span' ).html( data.responseJSON.observaciones )
    $( '#modalVehicle' ).modal( 'show' )

  # Callback for rendering via JSON (not remote versión, not used right now)
  $('a.vehicle[data-type=json]').bind 'ajax:complete', (event, data, status, xhr) ->
      $( '#modalVehicle .modal-header h3' ).html( "Vehículo matrícula" + " " + data.responseJSON.matricula )
      $( '#modalVehicle .modal-body .pmatricula span' ).html( data.responseJSON.matricula )
      $( '#modalVehicle .modal-body .pparticular span' ).html( formatBooleano( data.responseJSON.compra_venta ) )
      $( '#modalVehicle .modal-body .pcomprav span' ).html( formatBooleano( data.responseJSON.compra_venta ) )
      $( '#modalVehicle .modal-body .pmarca span' ).html( data.responseJSON.marca )
      $( '#modalVehicle .modal-body .pmodelo span' ).html( data.responseJSON.modelo )
      $( '#modalVehicle .modal-body .pcomprador span' ).html( data.responseJSON.comprador )
      $( '#modalVehicle .modal-body .pft span' ).html( formatBooleano( data.responseJSON.ft ) )
      $( '#modalVehicle .modal-body .ppc span' ).html( formatBooleano( data.responseJSON.pc ) )
      $( '#modalVehicle .modal-body .pitv span' ).html( fechaLocal( data.responseJSON.fecha_itv ) )
      $( '#modalVehicle .modal-body .pincidencia span' ).html( data.responseJSON.incidencia )
      $( '#modalVehicle .modal-body .pfec span' ).html( fechaLocal( data.responseJSON.fecha_expediente_completo ) )
      $( '#modalVehicle .modal-body .pfde span' ).html( fechaLocal( data.responseJSON.fecha_documentacion_enviada ) )
      $( '#modalVehicle .modal-body .pfnc span' ).html( fechaLocal( data.responseJSON.fecha_notificado_cliente ) )
      $( '#modalVehicle .modal-body .pfdr span' ).html( fechaLocal( data.responseJSON.fecha_documentacion_recibida ) )
      $( '#modalVehicle .modal-body .pfeg span' ).html( fechaLocal( data.responseJSON.fecha_envio_gestoria ) )
      $( '#modalVehicle .modal-body .pbajae span' ).html( data.responseJSON.baja_exportacion )
      $( '#modalVehicle .modal-body .pfed span' ).html( fechaLocal( data.responseJSON.fecha_entregado_david ) )
      $( '#modalVehicle .modal-body .pfedf span' ).html( fechaLocal( data.responseJSON.fecha_envio_definitiva ) )
      $( '#modalVehicle .modal-body .pobservaciones span' ).html( data.responseJSON.observaciones )
      $( '#modalVehicle' ).modal( 'show' )
  
  # IE8- rounded borders through PIE.js
  if window.PIE
    $(".pie").each ->
      PIE.attach this