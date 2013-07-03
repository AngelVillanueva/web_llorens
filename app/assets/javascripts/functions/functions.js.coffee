###
Shared functions
###

# polling Justificantes table data
@updateJustificantes = ->
    if( $('tr.justificante').length )
      after = $('tr.justificante:eq(0)').attr('data-time')
      $.getScript('/online/justificantes.js?after=' + after)
      setTimeout(updateJustificantes, 10000)

# polling Informes table data
@updateInformes = ->
    if( $('tr.informe').length )
      after = $('tr.informe:eq(0)').attr('data-time')
      $.getScript('/online/informes.js?after=' + after)
      setTimeout(updateInformes, 10000)

# datepicker localization (es)
@configureDatePicker = ->
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
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.regional[""].dateFormat = 'dd/mm/yy';
  $.datepicker.setDefaults($.datepicker.regional['']);
  $.datepicker.setDefaults($.datepicker.regional['es'])

# table tools configuration: set classes to something suitable for Bootstrap
@configureTableTools = ->
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
  } )

# custom search box for dataTables functionality
@createSearchBox = ->
  $input = $('.dataTables_filter input')
  model = $input.attr( 'aria-controls' )
  $dataT = $( '#' + model )
  $input.data('val',  $input.val() ); # save value
  $input.change ->
    $dataT.dataTable().fnFilter( $input.val() )
  $input.keyup ->
    if ( $input.val() is '' || ( $input.val() != $input.data( 'val' ) && $input.val().length >= 3 ) )
      $input.data( 'val', $input.val )
      $( this ).change()

# create DataTable
@createDataTable = ( selector, excelname, exportcolumns, filtercolumns ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
            "sFileName": excelname + ".xls",
            "mColumns": exportcolumns,
            "sCharSet": "utf16le"
          }

        ]
      }
    }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# move Export to Excel Button to Tools div
@moveExportExcelButton = ->
  $button = $('a.DTTT_button_xls')
  $('<li class="here"/>').appendTo('.tools ul')
  $button.children('span').remove()
  $('<i class="icon icon-save icon-2x"/>').appendTo($button)
  $button.removeClass('btn').appendTo('.tools ul li:last')
  $('.dataTables_wrapper').children('div.row:first').remove()
  $('li.here').tooltip({'title': 'Exportar Excel'})