class Online::StockVehiclesController < OnlineController
  before_filter :check_remarketing
  load_and_authorize_resource :stock_vehicle, through: :cliente
  expose( :cliente )
  #expose( :stock_vehicles ) { cliente.stockvehicles.accessible_by( current_ability ).page( params[ :page ] ) } # commented until dataTables -> remote
    expose( :stock_vehicles ) { cliente.stock_vehicles.accessible_by(current_ability).page( params[ :page ] ).per( 10 ) }
  expose( :stock_vehicle, attributes: :stock_vehicle_params )

  def index
    respond_to do |format|
      format.html
      format.json { render json: StockVehiclesDatatable.new( view_context, current_ability, cliente ) }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: stock_vehicle }
    end
  end

  private
  def stock_vehicle_params
    if current_usuario
      params
      .require( :stock_vehicle )
      .permit!
    end
  end

  def check_remarketing
    cliente = Cliente.find( params[ :cliente_id ] )
    redirect_to root_path, flash: { :alert => I18n.t( "No existe aun" ) } unless cliente.has_remarketing?
  end

end