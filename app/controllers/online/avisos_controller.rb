class Online::AvisosController < ApplicationController
  expose( :avisos ) { current_usuario.avisos.vivos }

  def index
    respond_to do |format|
      format.json { render json: { avisos: avisos } }
    end
  end
end