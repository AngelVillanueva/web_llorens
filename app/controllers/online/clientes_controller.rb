class Online::ClientesController < OnlineController
  expose( :cliente, attributes: :cliente_params )

  private
  def cliente_params
    if current_usuario
      params
      .require( :cliente )
      .permit!
    end
  end
end