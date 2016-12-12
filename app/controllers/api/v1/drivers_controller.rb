class Api::V1::DriversController < ApplicationController
  skip_before_filter :authenticate_usuario!   # skip devise authentication
  before_filter :restrict_access              # apikey authentication (private method, below)
  respond_to :json
  # decent exposure and strong parameters block
  expose( :drivers ) { params[ :drivers ] }
  expose( :driver )

  def restrict_access
    unless Rails.env.test?
      authenticate_or_request_with_http_token do |token, options|
        if ApiKey.exists?(access_token: token)
          @apikey = ApiKey.find_by_access_token(token);
          @cli = Cliente.find(@apikey.cliente_id)
          @cli.has_remarketing?
        end
      end
    end
  end

  def index
    @drivers = Driver.where("entrega=false").order("fecha_matriculacion DESC");
    respond_to do |format|
      format.json { render :json => @drivers, :only => [:id,:identificador,:bastidor,:matricula,:fecha_matriculacion]}
    end
  end

  def show
    if Driver.exists?(params[:id])
      @driver = Driver.find(params[:id])
      respond_to do |format|
        format.json { render :json => @driver, :only => [:id,:identificador,:bastidor,:matricula,:fecha_matriculacion,:entrega]}
      end
    else
      respond_to do |format|
        format.json { render :json => {:message => "Driver not found"}}
      end
    end
  end

  def update
    if Driver.exists?(params[:id])
      @driver = Driver.find(params[:id])
      unless @driver.entrega?
        if params[:driver][:direccion]
          @driver.direccion = params[:driver][:direccion]
        end
        if params[:driver][:comentarios]
          @driver.observaciones_cliente = params[:driver][:comentarios]
        end
        if params[:driver][:entrega] == "ok"
          @driver.entrega = true
        end
        if @driver.save
          respond_to do |format|
              format.json { render :json => {:message => "Success"}}
          end
        end
      else
        respond_to do |format|
            format.json { render :json => {:message => "Ya editado"}}
        end
      end 
    else
      respond_to do |format|
          format.json { render :json => {:message => "Driver not found"}}
    end
   end
  end
end