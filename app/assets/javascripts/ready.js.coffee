$(document).ready -> 

  # change text on big buttons (hover)
  $( 'li.new a span' ).hover(
    -> $( this ).html( "+" )
    -> $( this ).html( $( this ).attr('class') )
  )

  # printThis binding
  $( 'a.print' ).click ->
    $( $(this).attr( 'data-print-area' ) ).printThis()

  # prepare the content if a table
  if ( $( 'table' ).length )
    configureDatePicker() # datepicker localization (es)
    configureTableTools() # set the tabletools classes to something Bootstrap-like
    createSearchBox() # custom search box for dataTables functionality

  ###
  dataTables initialization
  ###
  # expedientes
  if ( $( '#expedientes' ).length )
    createDataTable(
      'expedientes',
      "Expedientes_Llorens",
      [0,1,2,3,4,5,6,7,8,10], 
      [
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "text" },
        { type: "select" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "date-range" },
        { type: "select" },
        null,
        null
      ]
    )
  
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
        null
      ]
    )
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
        null
      ]
    )
    $( '.new' ).fadeIn(); # reveal new records
    setTimeout(updateInformes, 10000) # fired polling for new records

  # search link in Tools div
  $( 'a.search' ).click ->
    $( '.dataTables_filter' ).slideToggle()
    false

  # move 'Export to Excel' functionality
  if TableTools.fnGetMasters().length
    moveExportExcelButton()