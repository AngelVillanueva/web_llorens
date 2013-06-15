function updateInformes() {
  var after = 0;
  if( $('tr.informe').length ) {
    after = $('tr.informe:eq(0)').attr('data-time');
  }
  $.getScript('/online/informes.js?after=' + after);
  setTimeout(updateInformes, 10000);
}