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
    error_count = 0
    exp_list = []
    cliente_recibido = params[:expediente][:cliente_id]
    expediente = expediente_type.where(identificador: expediente_params[:identificador]).first
    # it is a new one
    if expediente.nil?
      expediente = expediente_type.new(expediente_params)
      if expediente.save
        resultado = create_response(0, "New", expediente, "success")
        render json: resultado
        exp_list << resultado
      elsif check_special cliente_recibido
        resultado = create_response(0, "New", expediente, "special", cliente_recibido)
        render json: resultado
        exp_list << resultado
      else
        resultado = create_response(0, "New", expediente, "error", cliente_recibido)
        render json: resultado, status: :unprocessable_entity
        error_count = 1
        exp_list << resultado
      end
    # it is an already existing Expediente
    else
      if expediente.update_attributes(expediente_params expediente.fecha_alta)
        resultado = create_response(0, "Edit", expediente, "success")
        render json: resultado
        exp_list << resultado
      elsif check_special cliente_recibido
        resultado = create_response(0, "Edit", expediente, "special", cliente_recibido)
        render json: resultado
        exp_list << resultado
      else
        resultado = create_response(0, "Edit", expediente, "error", cliente_recibido)
        render json: resultado, status: :unprocessable_entity
        error_count = 1
        exp_list << resultado
      end
    end
    respuesta = response_block(1, error_count, exp_list)
    Rails.application.config.api_logger.debug respuesta
    if error_count > 0
      ApiMailer.api_error_message(respuesta).deliver
    end
  end

  # this action process a json with multiples records
  # and creates (or updates) them
  ###############################
  def create_batch
    exp_list = []
    exp_err_list = []
    error_count = 0
    expedientes.each_with_index do |item, index|
      this_is_error = false
      expediente = expedientes[index][:expediente][:type].constantize.where(identificador: expedientes[index][:expediente][:identificador]).first
      cliente_recibido = expedientes[index][:expediente][:cliente_id]
      # it is a new Expediente
      if expediente.nil?
        type = "New"
        expediente = expedientes[index][:expediente][:type].constantize.new( this_expediente_params( index ) )
        if expediente.save
          result = "success"
        elsif check_special cliente_recibido
          result = "special"
        else
          result = "error"
          error_count = error_count + 1
          this_is_error = true
        end
      # it is an already existing Expediente
      else
        type = "Edit"
        if expediente.update_attributes( this_expediente_params( index, expediente.fecha_alta ) )
          result = "success"
        elsif check_special cliente_recibido
          result = "special"
        else
          result = "error"
          error_count = error_count + 1
          this_is_error = true
        end
      end
      exp_list << create_response(index, type, expediente, result, cliente_recibido) # add a response object for the received record
      if this_is_error
        exp_err_list << create_response(index, type, expediente, result, cliente_recibido) # add a response object for the received record
        this_is_error = false
      end
    end
    render json: exp_list
    respuesta = response_block(expedientes.count, error_count, exp_list)
    respuesta_email = response_block(expedientes.count, error_count, exp_err_list)
    Rails.application.config.api_logger.debug respuesta
    if error_count > 0
      ApiMailer.api_error_message(respuesta_email).deliver
    end
  end

  private
  def expediente_params previous_fecha_alta=nil
    params[:expediente].delete :type # to avoid Mass Assignment Error [:type is reserved]
    params[:expediente] = complete_fecha_alta_if_needed params[:expediente], previous_fecha_alta # just in case an update with empty fecha_alta but informed fecha_entra or fecha_facturacion
    params[:expediente] = assign_internal_cliente_id params[:expediente]
    params
      .require( :expediente )
      .permit( :identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :cliente_id, :llorens_cliente_id, :observaciones, :incidencia, :fecha_resolucion_incidencia )
  end
  def this_expediente_params index, previous_fecha_alta=nil
    params[:expedientes][index][:expediente].delete :type
    params[:expedientes][index][:expediente] = complete_fecha_alta_if_needed params[:expedientes][index][:expediente], previous_fecha_alta
    params[:expedientes][index][:expediente] = assign_internal_cliente_id params[:expedientes][index][:expediente]
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

  def create_response index, type, received, result, cliente_recibido=nil
    response_message = []
    response_message << { :timestamp => Time.now.strftime("%d/%m/%Y %I:%M") }
    response_message << {:tipo => I18n.t(type, index: index+1)}
    case result
    when "success"
      response_message << {:resultado => I18n.t("Correcto")}
    when "special"
      response_message << {:resultado => I18n.t("Especial")}
      response_message << {:id_cliente_recibido => cliente_recibido }
    when "error"
      response_message << {:resultado => I18n.t("Incorrecto")}
      response_message << {:errores => received.errors.messages}
      response_message << {:id_cliente_recibido => cliente_recibido }
    end
    response_message << received
    response_message
  end

  def response_block expedientes_count, error_count, expedientes_list
    rb = [] << { :timestamp => Time.now.strftime( "%d/%m/%Y %I:%M" ) }
    recibidos = expedientes_count
    case
    when error_count == 0
      resultado = "Completamente correcto"
    when error_count == recibidos
      resultado = "Error total"
    when recibidos > error_count && error_count > 0
      resultado = "Parcialmente correcto"
    else
      resultado = "Error fatal"
    end
    rb << { :resultado => resultado }
    rb << { :recibidos => recibidos }
    rb << { :guardados => recibidos - error_count }
    rb << { :errores => error_count }
    rb << { :detalle => expedientes_list }
    rb.to_yaml
  end

  # this method allows to mark special clients to not being considered
  def check_special llorens_cliente_id
    specials = ["4300999999"]
    # 4300999999 is for non-company customers, not to be considered
    specials.include? llorens_cliente_id
  end
end
