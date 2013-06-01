class Api::V1::ExpedientesController < ApplicationController
  skip_before_filter :authenticate_usuario!
  respond_to :json
  expose( :expediente )
  expose( :expediente_type ) { params[:expediente][:type].constantize }

  def create
    expediente = expediente_type.new(expediente_params)
    if expediente.save
      respond_with(expediente)
    else
      render json: expediente.errors, status: :unprocessable_entity
    end
  end

  private
  def expediente_params
    params[:expediente].delete :type # to avoid Mass Assignment Error [:type is reserved]
    params
      .require( :expediente )
      .permit( :identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :organizacion_id, :observaciones )
  end
end
