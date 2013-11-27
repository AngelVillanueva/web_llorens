//= require rich/base

// disable Rich auto-added navigation
$(document).ready(function(){
  if( $( 'li[data-model^=rich]' ).length ) {
    link = $( 'li[data-model^=rich]:eq(0)' );
    $( link ).hide();
    $( link ).siblings('li.nav-header:eq(1)').hide();
  }

});