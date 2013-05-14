class Api::V1::ExpedientesController < ApplicationController
  respond_to :json
  expose(:expediente)

  def create
    expediente = Expediente.new(expediente_params)
    if expediente.save
      respond_with(expediente)
    else
      respond_with(render json: expediente.errors, status: :unprocessable_entity)
    end
  end

  private
  def expediente_params
    params
      .require(:expediente)
      .permit(:identificador)
  end
end
