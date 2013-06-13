function updateInformes() {
  var after = $('tr.informe:first').attr('data-time');
  $.getScript('/online/informes.js?after=' + after);
  setTimeout(updateInformes, 10000);
}