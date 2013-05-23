class ExpedientesController < ApplicationController
  expose( :documento ) { Expediente.where( identificador: params[:id] ).first }
  expose( :expedientes ) { current_usuario.expedientes }
  expose( :expediente, attributes: :expediente_params )

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

  def pdf
    documento 
  end

  private
  def expediente_params
    # params
    #   .require( :expediente )
    #   .permit( :identificador, :matricula )
  end

end