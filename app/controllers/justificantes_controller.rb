class JustificantesController < ApplicationController
  expose( :justificantes )
  expose( :justificante, attributes: :justificante_params )

  def create
    if justificante.save
      flash[:success] = "Nuevo justificante creado correctamente"
      redirect_to(justificantes_path)
    else
      flash[:error] = "Se ha producido un error creando el justificante"
      render :new
    end
  end

  private
  def justificante_params
    if current_usuario
      params
        .require( :justificante )
        .permit!
    end
  end
end