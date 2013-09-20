class Api::V1::ExpedientesController < ApplicationController
  skip_before_filter :authenticate_usuario!   # skip devise authentication
  before_filter :restrict_access              # apikey authentication (private method, below)
  respond_to :json                            # api is json driven
  # decent exposure and strong parameters block
  expose( :expedientes ) { params[ :expedientes ] }
  expose( :expediente )
  expose( :expediente_type ) { params[:expediente][:type].constantize }

  
  # this action process a json with a single record
  # and creates (or updates) it
  ##############################
  def create_or_update_single
    cliente_recibido = params[:expediente][:cliente_id]
    expediente = expediente_type.where(identificador: expediente_params[:identificador]).first
    # it is a new one
    if expediente.nil?
      expediente = expediente_type.new(expediente_params)
      if expediente.save
        render json: create_response("New", expediente, "success")
      else
        render json: create_response("New", expediente, "error", cliente_recibido), status: :unprocessable_entity
      end
    # it is an already existing Expediente
    else
      if expediente.update_attributes(expediente_params expediente.fecha_alta)
        render json: create_response("Edit", expediente, "success")
      else
        render json: create_response("Edit", expediente, "error", cliente_recibido), status: :unprocessable_entity
      end
    end
  end

  # this action process a json with multiples records
  # and creates (or updates) them
  ###############################
  def create_batch
    exp_list = []
    expedientes.each_with_index do |item, index|
      expediente = expedientes[index][:expediente][:type].constantize.where(identificador: expedientes[index][:expediente][:identificador]).first
      # it is a new Expediente
      if expediente.nil?
        type = "New"
        expediente = expedientes[index][:expediente][:type].constantize.new( this_expediente_params( index ) )
        if expediente.save
          result = "success"
        else
          result = "error"
        end
      # it is an already existing Expediente
      else
        type = "Edit"
        if expediente.update_attributes( this_expediente_params( index, expediente.fecha_alta ) )
          result = "success"
        else
          result = "error"
        end
      end
      exp_list << create_response(type, expediente, result) # add a response object for the received record
    end
    render json: exp_list
  end

  private
  def expediente_params previous_fecha_alta=nil
    params[:expediente].delete :type # to avoid Mass Assignment Error [:type is reserved]
    params[:expediente] = complete_fecha_alta_if_needed params[:expediente], previous_fecha_alta # just in case an update with empty fecha_alta but informed fecha_entra or fecha_facturacion
    params[:expediente] = assign_internal_cliente_id params[:expediente]
    params
      .require( :expediente )
      .permit( :identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :cliente_id, :llorens_cliente_id, :observaciones )
  end
  def this_expediente_params index, previous_fecha_alta=nil
    params[:expedientes][index][:expediente].delete :type
    params[:expedientes][index][:expediente] = complete_fecha_alta_if_needed params[:expedientes][index][:expediente], previous_fecha_alta
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

  def complete_fecha_alta_if_needed params, previous
    params[:fecha_alta] = previous if params[:fecha_alta].to_s.empty?
    params
  end

  def assign_internal_cliente_id params
    # move llorens cliente id to a specific field just if coming from the json message (string field)
    params[:llorens_cliente_id] = params[:cliente_id].to_s if params[:cliente_id].is_a?(String)
    # fill cliente_id info with the internal cliente id if exists or make it nil
    unless params[:cliente_id].nil?
      internal_cliente = Cliente.where(llorens_cliente_id: params[:llorens_cliente_id]).first
      unless internal_cliente.nil?
        params[:cliente_id] = internal_cliente.id.to_i # makes cliente_id integer to avoid being moved again to llorens_cliente_id
      else
        params[:cliente_id] = nil
      end
    end
    params
  end

  def create_response type, received, result, cliente_recibido=nil
    response_message = []
    response_message << {:tipo => I18n.t(type)}
    response_message << received
    case result
    when "success"
      response_message << {:resultado => I18n.t("Correcto")}
    when "error"
      response_message << {:resultado => I18n.t("Incorrecto")}
      response_message << {:errores => received.errors}
      response_message << {:id_cliente_recibido => cliente_recibido }
    end
    response_message
  end
end
