class Online::StaticPagesController < OnlineController
  expose( :avisos ) do
    current_usuario.avisos.vivos
  end
  
  def home
  end
end