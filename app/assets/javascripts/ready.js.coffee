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
    configureDatePicker()
      

  # dataTables: Set the classes that TableTools uses to something suitable for Bootstrap
  $.extend( true, $.fn.DataTable.TableTools.classes, {
    "container": "btn-group",
    "buttons": {
      "normal": "btn",
      "disabled": "btn disabled"
    },
    "collection": {
      "container": "DTTT_dropdown dropdown-menu",
      "buttons": {
        "normal": "",
        "disabled": "disabled"
      }
    }
  } );

  # dataTables initialization

  $('.expedientes').dataTable( {
    "sDom": "<'row'<'span6'T><'span6 pull-right'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "oLanguage": {
        "sSearch": "Buscar en la tabla",
        "sLengthMenu": "Mostrar _MENU_ entradas por página",
        "sZeroRecords": "Lo siento, no hay resultados",
        "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
        "sInfoEmpty": "Mostrando 0 a 0 de 0 entradas",
        "sInfoFiltered": "(filtrado de _MAX_ total entradas)"
    },
    "oTableTools": {
      "aButtons": [
        {
          "sExtends":    "xls",
          "sButtonText": "Exportar a Excel",
          "sFileName": "Expedientes_Llorens.xls",
          "mColumns": [0,1,2,3,4,5,6,7,8,9,10,11,12],
          "sCharSet": "utf16le"
        }

      ]
    }
  } ).columnFilter( {
    sPlaceHolder: "head:before",
    sRangeFormat: "De {from} a {to}",
    aoColumns: [
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "select" },
      { type: "select" },
      { type: "date-range" },
      { type: "date-range" },
      { type: "date-range" },
      null,
      null,
      null,
      null
      ]
  }
  );
  $('.justificantes').dataTable( {
    "sDom": "<'row'<'span6'T><'span6 pull-right'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "oLanguage": {
        "sSearch": "Buscar en la tabla",
        "sLengthMenu": "Mostrar _MENU_ entradas por página",
        "sZeroRecords": "Lo siento, no hay resultados",
        "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
        "sInfoEmpty": "Mostrando 0 a 0 de 0 entradas",
        "sInfoFiltered": "(filtrado de _MAX_ total entradas)"
    },
    "oTableTools": {
      "aButtons": [
        {
          "sExtends":    "xls",
          "sButtonText": "Exportar a Excel",
          "sFileName": "Justificantes_Llorens.xls",
          "mColumns": [0,1,2,3,4,5,6,7,8,9,10],
          "sCharSet": "utf16le"
        }

      ]
    }
  } ).columnFilter( {
    sPlaceHolder: "head:before",
    sRangeFormat: "De {from} a {to}",
    aoColumns: [
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "text" },
      { type: "select" },
      { type: "text" },
      { type: "date-range" },
      { type: "date-range" },
      null
      ]
  }
  );
  $('.informe_traficos').dataTable( {
    "sDom": "<'row'<'span6'T><'span6 pull-right'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "oLanguage": {
        "sSearch": "Buscar en la tabla",
        "sLengthMenu": "Mostrar _MENU_ entradas por página",
        "sZeroRecords": "Lo siento, no hay resultados",
        "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
        "sInfoEmpty": "Mostrando 0 a 0 de 0 entradas",
        "sInfoFiltered": "(filtrado de _MAX_ total entradas)"
    },
    "oTableTools": {
      "aButtons": [
        {
          "sExtends":    "xls",
          "sButtonText": "Exportar a Excel",
          "sFileName": "Informes_Llorens.xls",
          "mColumns": [0,1,2,3,5],
          "sCharSet": "utf16le"
        }

      ]
    }
  } ).columnFilter( {
    sPlaceHolder: "head:before",
    sRangeFormat: "De {from} a {to}",
    aoColumns: [
      { type: "select" },
      { type: "text" },
      { type: "text" },
      { type: "date-range" },
      null,
      { type: "select" },
      null,
      null
      ]
  }
  );

  