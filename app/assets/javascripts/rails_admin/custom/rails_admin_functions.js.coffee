  $(document).ready ->
    alert "hola"
    # hide Rich added menus in RailsAdmin
    if ( $('li[data-model=usuario]').length )
      alert "yes"