class Online::StockVehiclesController < OnlineController
  load_and_authorize_resource
  expose( :cliente ) { Cliente.find( params[:id] ) }
  expose( :stock_vehicles ) { StockVehicle.accessible_by( current_ability ).page( params[ :page ] ).per( 10 )}
  expose( :stock_vehicle, attributes: :stock_vehicle_params )

  private
  def stock_vehicle_params
    if current_usuario
      params
      .require( :stock_vehicle )
      .permit!
    end
  end
end