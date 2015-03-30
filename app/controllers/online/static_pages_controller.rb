class Online::StaticPagesController < OnlineController
  expose( :avisos ) do
    current_usuario.avisos.vivos
  end
  
  def home
  	organizacion = Organizacion.find(current_usuario.organizacion_id)
  	@view_mandato = organizacion.view_mandato
  end
end