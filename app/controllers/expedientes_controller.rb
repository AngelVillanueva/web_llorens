class ExpedientesController < ApplicationController
  load_and_authorize_resource
  expose( :expedientes ) { Expediente.accessible_by( current_ability ) }
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