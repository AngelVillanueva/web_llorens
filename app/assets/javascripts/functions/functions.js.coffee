###
Shared functions
###

root = exports ? this
root._gaq = [['_setAccount', 'UA-44468535-1'], ['_trackPageview']]
root.analytics_loaded = false

# inject analytics tracking code
@injectAnalytics = ->
  ga = document.createElement 'script'
  ga.type = 'text/javascript'
  ga.async = true
 
  proto = document.location.protocol
  proto = if (proto is 'https:') then 'https://ssl' else 'http://www'
  ga.src = "#{proto}.google-analytics.com/ga.js"
  
  s = document.getElementsByTagName 'script'
  $(ga).insertBefore(s[0])
  root.analytics_loaded = true # so there please do not load it again

# check if CookiePolicy cookie already exists to show or not the warning
@checkdCookiesPolicyCookie = ->
  dcplyName = "DCKPLCY"
  unless existsCookie(dcplyName)
    $("#d-policy-disclaimer").show()
  else
    $("#d-policy-disclaimer").hide()
    injectAnalytics()

@setCookiePolicyOnAction = (the_action) ->
  dcplyName = "DCKPLCY"
  dcplyExpireDate = new Date()
  expireMonths = 1
  action = the_action
  dcplyExpireDate.setMonth dcplyExpireDate.getMonth() + expireMonths
  setCookieValue dcplyName, action, dcplyExpireDate
  $( '#d-policy-disclaimer' ).hide()
  injectAnalytics() unless analytics_loaded

# polling Justificantes table data
# @updateJustificantes = ->
#     if( $('tr.justificante').length )
#       after = $('tr.justificante:eq(0)').attr('data-time')
#       $.getScript('/online/justificantes.js?after=' + after)
#       setTimeout(updateJustificantes, 10000)
#       setInterval(updateScreen, 15000)

@updateJustificantesNewVersion = ->
  if( $('tr.justificante').length )
    setInterval(updateScreen, 240000)

# polling Informes table data
# @updateInformes = ->
#     if( $('tr.informe').length )
#       after = $('tr.informe:eq(0)').attr('data-time')
#       $.getScript('/online/informes.js?after=' + after)
#       setTimeout(updateInformes, 10000)
#       setInterval(updateScreen, 15000)

@updateInformesNewVersion = ->
  if( $('tr.informe').length )
    setInterval(updateScreen, 240000)

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
@createDataTable = ( selector, sortcolumn, columntypes, excelname, exportcolumns, filtercolumns ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "aoColumns": columntypes,
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

# create simple DataTable
@createSimpleDataTable = ( selector, sortcolumn, filtercolumns ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "oLanguage": {
          "sSearch": "Buscar en la tabla",
          "sLengthMenu": "Mostrar _MENU_ entradas por página",
          "sZeroRecords": "Lo siento, no hay resultados",
          "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
          "sInfoEmpty": "Mostrando 0 a 0 de 0 entradas",
          "sInfoFiltered": "(filtrado de _MAX_ total entradas)"
        }
      }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# create simple remote DataTable for Stock Vehicles
@createRemoteVehiclesDataTable = ( selector, sortcolumn, filtercolumns ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": oTable.data('source'),
      "fnRowCallback": ( nRow, aData, iDisplayIndex ) ->
        $(nRow).addClass('stock');
        $('td', nRow).slice(1,2).addClass('sold')
        $('td', nRow).slice(2,3).addClass('completed')
        $('td', nRow).slice(3,4).addClass('sent')
        $('td', nRow).slice(4,5).addClass('received')
        $('td', nRow).slice(5,6).addClass('definitive')
        $('td', nRow).slice(6,7).addClass('finished')
        $('td:last', nRow).addClass('icon')
        return nRow
      "oLanguage": {
          "sSearch": "Buscar en la tabla",
          "sLengthMenu": "Mostrar _MENU_ entradas por página",
          "sZeroRecords": "Lo siento, no hay resultados",
          "sInfo": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
          "sInfoEmpty": "Mostrando 0 a 0 de 0 entradas",
          "sInfoFiltered": "(filtrado de _MAX_ total entradas)"
        }
      }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# create remote DataTable
@createRemoteDataTable = ( selector, sortcolumn, columntypes, excelname, exportcolumns, filtercolumns, datecolumns=[] ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "aoColumns": columntypes,
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": oTable.data('source'),
      "fnRowCallback": ( nRow, aData, iDisplayIndex ) ->
        $(nRow).addClass('expediente');
        $('td', nRow).slice(1,2).addClass('matricula')
        $('td:last', nRow).addClass('icon')
        return nRow
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
            "sExtends": "download",
            "sButtonText": "Download CSV",
            "sUrl": oTable.data('xls'), # use 'csv' to export in CSV instead of XLS
            "sInputName": selector,
            "sExtraData": datecolumns,
            "sCharSet": "utf16le"
          }

        ]
      }
    }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# create remote DataTable for Justificantes
@createRemoteJustificantesDataTable = ( selector, sortcolumn, columntypes, excelname, exportcolumns, filtercolumns, datecolumns=[] ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "aoColumns": columntypes,
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": oTable.data('source'),
      "fnRowCallback": ( nRow, aData, iDisplayIndex ) ->
        $(nRow).addClass('justificante');
        $(nRow).addClass('new') if aData[15]==null
        $('td', nRow).slice(0,15).addClass('printable')
        $('td', nRow).slice(7,14).addClass('hidden')
        $('td', nRow).slice(10,12).removeClass('hidden').addClass('hideie8')
        $('td', nRow).slice(15,17).addClass('icon')
        return nRow
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
            "sExtends": "download",
            "sButtonText": "Download CSV",
            "sUrl": oTable.data('xls'), # use 'csv' to export in CSV instead of XLS
            "sInputName": selector,
            "sExtraData": datecolumns,
            "sCharSet": "utf16le"
          }

        ]
      }
    }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# create remote DataTable for Informes
@createRemoteInformesDataTable = ( selector, sortcolumn, columntypes, excelname, exportcolumns, filtercolumns, datecolumns=[] ) ->
  oTable = $( '#' + selector )
  if ( oTable.length )
    oTable.dataTable({
      "sDom": "<'row'<'span6'T><'span6 pull-right'>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      "aaSorting": sortcolumn,
      "aoColumns": columntypes,
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": oTable.data('source'),
      "fnRowCallback": ( nRow, aData, iDisplayIndex ) ->
        $(nRow).addClass('informe');
        $(nRow).addClass('new') if aData[5]=="Pendiente"
        $('td', nRow).slice(0,5).addClass('printable')
        $('td', nRow).slice(5,7).addClass('icon')
        return nRow
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
            "sExtends": "download",
            "sButtonText": "Download CSV",
            "sUrl": oTable.data('xls'), # use 'csv' to export in CSV instead of XLS
            "sInputName": selector,
            "sExtraData": datecolumns,
            "sCharSet": "utf16le"
          }

        ]
      }
    }).columnFilter({
      sPlaceHolder: "head:before",
      sRangeFormat: "De {from} a {to}",
      aoColumns: filtercolumns
    })

# move Export to Excel/CSV Button to Tools div
@moveExportButton = ->
  #$button = $('a.DTTT_button_xls')
  $button = $('a.DTTT_button_text')
  $('<li class="tooltip-xls"/>').appendTo('.tools ul')
  $button.addClass('pie')
  $button.children('span').remove()
  $button.children('undefined').remove()
  $('<i class="icon icon-save icon-2x"/>').appendTo($button)
  $button.removeClass('btn').appendTo('.tools ul li:last')
  $('.dataTables_wrapper').children('div.row:first').remove()
  $('li.tooltip-xls').tooltip({'title': 'Exportar XLS'})


# print a table row
@printRow = (row) ->
  tipo = $( 'h2.section_header span:eq(0)' ).text().split(" ")[0].toUpperCase()
  $( '<div id="toPrint" class="printable" />' ).appendTo( 'body' )
  $( '<h3>Resumen para Imprimir</h3><hr/><h4>' + tipo + '</h4>' ).appendTo( '#toPrint' )
  $( '<ul id="printList" />' ).appendTo( '#toPrint' )
  $( row ).children('td.printable').each (i) ->
    #titular = $( this ).attr( 'data-titular' )
    titular = $( "#"+ tipo.toLowerCase() + " tr.titles th:eq(" + i + ")").text()
    contenido = $( this ).html()
    $( '<li><span class="titular">' + titular + ':</span><span class="contenido">' + contenido + '</span></li>').appendTo( '#printList' )
  $( '#toPrint' ).printThis()
  $( '#toPrint' ).remove()

# force page reload
@updateScreen = ->
  location.reload(true)

# handle Apellidos for new Justificante request
@handleNewJustificanteApellidos = ->
  changeApellidosLabelText()
  $( 'div.justificante_primer_apellido, div.justificante_segundo_apellido' ).toggle()

@changeApellidosLabelText = ->
  label = $( '.justificante_nombre_razon_social label' )
  acc_label = $( '.justificante_nif_comprador label' )
  now = $( label ).text()
  switch now
    when "* Nombre"
      new_text = "* Razón social"
      acc_new_text = "* CIF del comprador"
    when "* Razón social"
      new_text = "* Nombre"
      acc_new_text = "* NIF del comprador"
  $( label ).text( new_text )
  $( acc_label ).text( acc_new_text )

# take cares of First name as mandatory field just for people (not companies)
@handleFirstNameIfNotACompany = ->
  acompany = $( '#imacompany' ).prop( 'checked' )
  first_name = $( '#justificante_primer_apellido' ).val()
  if !acompany && !first_name
    $( '#primer_apellido_modal' ).modal( 'show' )
    return false

# returns a date in local formatting (es)
@fechaLocal = (fecha) ->
  if fecha
    a_date = fecha.split( "-" )
    year = a_date[0]
    month = a_date[1]
    day = a_date[2]
    return day + "/" + month + "/" + year
  else
    "Pendiente"

 # returns an icon check if boolean value is true
 @formatBooleano = (value) ->
  if value
    "<i class='icon icon-check'></i>"

 # gets living Avisos for current usuario
 @getAvisos = ->
  response = $.ajax '/online/avisos',
    type: 'GET',
    dataType: 'json',
    contentType: "application/json",
    error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
        $.each data.avisos, ( index, aviso ) ->
          showIfNotShown( aviso )
          # unless alreadyShown( aviso )
          #   div = $( '.hide .pulled_aviso:first' )
          #   div.parent('.row').clone().prependTo('.container .row:first')
          #   div.children( 'h4' ).html(aviso.titular)
          #   div.children( '.contenido' ).html(aviso.contenido)
          #   div.attr( 'id', '#av' + aviso.id )
          #   div.parent('.row').removeClass( 'hide' )
          #   setAvisoAsShown( aviso )
  
  @showIfNotShown = (aviso) ->
    # ajax request that returns true if the Aviso is already shown
    shown_request = $.ajax "/online/avisos/#{aviso.id}.json",
      type: 'GET',
      dataType: 'json',
      contentType: 'application/json',
      error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        unless data.shown == "true" # do not show Avisos that are already in screen
          showAvisoDiv( aviso )
          # div = $( '.hide .pulled_aviso:first' )
          # div.parent('.row').clone().prependTo('.container .row:first')
          # div.children( 'h4' ).html(aviso.titular)
          # div.children( '.contenido' ).html(aviso.contenido)
          # div.attr( 'id', '#av' + aviso.id )
          # div.parent('.row').removeClass( 'hide' )
          # changeAvisoStatus( aviso, "true" )
  @showAvisoDiv = ( aviso ) ->
    div = $( '.hide .pulled_aviso:first' )
    div.parent('.row').clone().prependTo('.container .row:first')
    div.children( 'h4' ).html(aviso.titular)
    div.children( '.contenido' ).html(aviso.contenido)
    div.attr( 'id', '#av' + aviso.id )
    div.parent('.row').removeClass( 'hide' )
    changeAvisoStatus( aviso, "true" )
    
  @changeAvisoStatus = (aviso, status) ->
    # ajax request that marks an Aviso as already shown
    $.ajax "online/avisos/#{aviso.id}/change_shown_status",
      type: 'POST',
      data: JSON.stringify({ "shown": status }),
      dataType: 'json',
      contentType: "application/json",
      error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
