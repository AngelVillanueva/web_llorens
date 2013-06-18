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
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''};
  $.datepicker.setDefaults($.datepicker.regional['es'])