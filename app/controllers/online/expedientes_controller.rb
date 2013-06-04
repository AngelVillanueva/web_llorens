class Online::ExpedientesController < OnlineController
  load_and_authorize_resource
  #expose( :expedientes ) { Expediente.accessible_by( current_ability ) }
  expose( :expedientes ) { expediente_type.scoped.accessible_by( current_ability ) }
  expose( :expediente_type ) { params[:type].constantize }
  expose( :expediente, attributes: :expediente_params )

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

  private
  def expediente_params
    # params
    #   .require( :expediente )
    #   .permit( :identificador, :matricula )
  end

end