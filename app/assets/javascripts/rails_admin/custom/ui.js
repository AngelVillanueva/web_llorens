//= require rich/base


$(document).ready(function(){

  // disable Rich auto-added navigation
  if( $( 'li[data-model^=rich]' ).length ) {
    link = $( 'li[data-model^=rich]:eq(0)' );
    $( link ).hide();
    $( link ).siblings('li.nav-header:eq(1)').hide();
  }

});