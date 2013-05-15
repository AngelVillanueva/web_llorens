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
  $('.table').dataTable( {
    "sDom": "<'row'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "oTableTools": {
      "aButtons": [
        {
          "sExtends":    "xls",
          "sButtonText": "Export to Excel",
          "sFileName": "Ejemplo.xls",
          "mColumns": [0,1,2,3,4,5,6,7,8,9,10,11,12],
          "sCharSet": "utf16le"
        }

      ]
    }
  } );
  