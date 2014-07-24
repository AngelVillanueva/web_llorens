class Online::AvisosController < ApplicationController
  expose( :avisos ) { current_usuario.avisos.vivos }
  expose( :aviso )

  def index
    respond_to do |format|
      format.json { render json: { avisos: avisos } }
    end
  end
  def show
    respond_to do |format|
      status = session[ "aviso_#{aviso.id}" ] == true ? true : false
      format.json { render json: { shown: status } }
    end
  end
  def change_shown_status
    respond_to do |format|
      format.json do
        parametros = shown_params
        session[ "aviso_#{aviso.id}" ] = parametros[:shown]
        render json: { shown: session[ "aviso_#{aviso.id}" ] }
      end
    end
  end

  private
  def shown_params
    params
      .permit!
  end
end