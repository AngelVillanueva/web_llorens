class Online::ClientesController < OnlineController
  before_filter :check_remarketing
  load_and_authorize_resource
  expose( :cliente, attributes: :cliente_params )

  private
  def cliente_params
    if current_usuario
      params
      .require( :cliente )
      .permit!
    end
  end
  def check_remarketing
    cliente = Cliente.find( params[:id] )
    redirect_to root_path, flash: { :alert => I18n.t( "No existe aun" ) } unless cliente.has_remarketing?
  end
end