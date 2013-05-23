$(document).ready ->
  # debug slider (not for production)
  if ($('#debug').size())
    $('#debug').hide()
    $('a.debug').click ->
      $('#debug').slideToggle()
      $('a.debug b').toggleClass('clicked')
      event.stopPropagation()
  

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

  $.datepicker.regional['es'] = {
    closeText: 'Cerrar',
    prevText: '&#x3c;Ant',
    nextText: 'Sig&#x3e;',
    currentText: 'Hoy',
    monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
    'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
    monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
    'Jul','Ago','Sep','Oct','Nov','Dic'],
    dayNames: ['Domingo','Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado'],
    dayNamesShort: ['Dom','Lun','Mar','Mi&eacute;','Juv','Vie','S&aacute;b'],
    dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S&aacute;'],
    weekHeader: 'Sm',
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['es']);

  $('.expedientes').dataTable( {
    "sDom": "<'row'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
    "sDom": "<'row'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
      { type: "select" },
      { type: "select" },
      null
      ]
  }
  );
  $('.informe_traficos').dataTable( {
    "sDom": "<'row'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
          "mColumns": [0,1,2,3],
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
      { type: "date-range" },
      { type: "select" },
      null,
      null
      ]
  }
  );
  