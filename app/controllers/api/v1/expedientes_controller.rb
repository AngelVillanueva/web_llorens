class Api::V1::ExpedientesController < ApplicationController
  skip_before_filter :authenticate_usuario!
  respond_to :json
  expose(:expediente)

  def create
    expediente = Expediente.new(expediente_params)
    if expediente.save
      respond_with(expediente)
    else
      render json: expediente.errors, status: :unprocessable_entity
    end
  end

  private
  def expediente_params
    params
      .require(:expediente)
      .permit(:identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :organizacion_id, :type)
  end
end
