$(document).ready -> 

  # change text on big buttons (hover)
  $( 'li.new a span' ).hover(
    -> $( this ).html( "+" )
    -> $( this ).html( $( this ).attr('class') )
  )

  # polling Justificantes table
  if ( $( '#justificantes' ).length )
    $( '.new' ).fadeIn();
    setTimeout(updateJustificantes, 10000)

  # polling Informes table
  if ( $( '#informes' ).length )
    $( '.new' ).fadeIn();
    setTimeout(updateInformes, 10000)

  # datepicker localization (es)
  if ( $( 'table' ).length )
    configureDatePicker() # datepicker localization (es)
    configureTableTools() # set the tabletools classes to something Bootstrap-like

  # dataTables initialization
  # expedientes
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
  # informes
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