class Online::StockVehiclesController < OnlineController
  before_filter :check_remarketing
  load_and_authorize_resource :stock_vehicle, through: :cliente
  expose( :cliente )
  #expose( :cliente ) { Cliente.find( params[:id] ) }
  expose( :stock_vehicles ) { StockVehicle.accessible_by( current_ability ).page( params[ :page ] ) }
  expose( :stock_vehicle, attributes: :stock_vehicle_params )


  private
  def stock_vehicle_params
    if current_usuario
      params
      .require( :stock_vehicle )
      .permit!
    end
  end

  def check_remarketing
    cliente = Cliente.find( params[ :id ] )
    redirect_to root_path, flash: { :alert => I18n.t( "No existe aun" ) } unless cliente.has_remarketing?
  end

end