class Api::V1::ExpedientesController < ApplicationController
  skip_before_filter :authenticate_usuario!   # skip devise authentication
  before_filter :restrict_access              # apikey authentication (private method, below)
  respond_to :json                            # api is json driven
  # decent exposure and strong parameters block
  expose( :expedientes ) { params[ :expedientes ] }
  expose( :expediente )
  expose( :expediente_type ) { params[:expediente][:type].constantize }

  
  # this action process a json with a single record and creates (or updates) it
  def create_or_update_single
    response_message = []
    expediente = expediente_type.where(identificador: expediente_params[:identificador]).first
    # it is a new one
    if expediente.nil?
      expediente = expediente_type.new(expediente_params)
      if expediente.save
        response_message << {:type => "edit"}
        response_message << expediente
        response_message << {:result => "success"}
        render json: response_message
      else
        render json: expediente.errors, status: :unprocessable_entity
      end
    # it is an already existing Expediente
    else
      if expediente.update_attributes(expediente_params)
        response_message << {:type => "new"}
        response_message << expediente
        response_message << {:result => "success"}
        render json: response_message
      else
        render json: expediente.errors, status: :unprocessable_entity
      end
    end
  end

  # this action process a json with multiples records and creates (or updates) them
  def create_batch
    exp_list = []
    expedientes.each_with_index do |item, index|
      expediente = expedientes[index][:expediente][:type].constantize.where(identificador: expedientes[index][:expediente][:identificador]).first
      # it is a new Expediente
      if expediente.nil?
        exp_list << "new"
        expediente = expedientes[index][:expediente][:type].constantize.new( this_expediente_params( index ) )
        if expediente.save
          exp_list << expediente
        else
          exp_list << expediente.errors
        end
      # it is an already existing Expediente
      else
        exp_list << "edit"
        if expediente.update_attributes( this_expediente_params( index ) )
          exp_list << expediente
        else
          exp_list << expediente.errors
        end
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
  def restrict_access
    unless Rails.env.test?
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end
  end
end
