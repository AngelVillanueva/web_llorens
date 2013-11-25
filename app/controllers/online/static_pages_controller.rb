class Online::StaticPagesController < OnlineController
  expose( :avisos ) do
    current_usuario.avisos
  end
  
  def home
  end
end