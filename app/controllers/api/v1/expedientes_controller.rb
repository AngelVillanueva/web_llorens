class Api::V1::ExpedientesController < ApplicationController
  skip_before_filter :authenticate_usuario!
  respond_to :json
  expose( :expedientes ) { params[ :expedientes ] }
  expose( :expediente )
  expose( :expediente_type ) { params[:expediente][:type].constantize }

  def create
    expediente = expediente_type.new(expediente_params)
    if expediente.save
      render json: expediente
    else
      render json: expediente.errors, status: :unprocessable_entity
    end
  end

  def create_batch
    exp_list = []
    expedientes.each_with_index do |item, index|
      expediente = expedientes[index][:expediente][:type].constantize.new( this_expediente_params( index ) )
      if expediente.save
        exp_list << expediente
      end
    end
    render json: exp_list
  end

  private
  def expediente_params
    params[:expediente].delete :type # to avoid Mass Assignment Error [:type is reserved]
    params
      .require( :expediente )
      .permit( :identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :cliente_id, :observaciones )
  end
  def this_expediente_params index
    params[:expedientes][index][:expediente].delete :type
    # DEV: move organizacion_id to Observaciones if is a string and add a temp cliente_id [SIGES int 64 issue]
      if params[:expedientes][index][:expediente][:cliente_id].is_a?(String)
        params[:expedientes][index][:expediente][:observaciones] = params[:expedientes][index][:expediente][:cliente_id]
        params[:expedientes][index][:expediente][:cliente_id] = 1001
      end
    # End of DEV
    params[:expedientes][index][:expediente]
  end
end
