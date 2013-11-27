//= require rich/base


$(document).ready(function(){

  // disable Rich auto-added navigation
  if( $( 'li[data-model^=rich]' ).length ) {
    link = $( 'li[data-model^=rich]:eq(0)' );
    $( link ).hide();
    $( link ).siblings('li.nav-header:eq(1)').hide();
  }

  // temporary hide of Aviso & Notificacion
  if( $( 'li[data-model=aviso]' ).length ) {
    link_aviso = $( 'li[data-model=aviso]:eq(0)' );
    $( link_aviso ).hide();
    $( 'li[data-model=notificacion]:eq(0)' ).hide();
  }

});