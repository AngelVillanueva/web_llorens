class ExpedientesController < ApplicationController
  expose(:expedientes)
  expose(:expediente, attributes: :expediente_params)

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

  private
  def expediente_params
    params
      .require( :expediente )
      .permit( :identificador, :matricula )
  end

end