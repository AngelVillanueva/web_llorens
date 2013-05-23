class JustificantesController < ApplicationController
  load_and_authorize_resource except: [:new, :create]
  expose( :justificantes ) { current_usuario.organizacion.justificantes }
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

  def update
    if justificante.update_attributes!(justificante_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless justificante.pdf_file_name.nil?
        justificante.identificador = justificante.pdf_file_name.gsub(".pdf", "")
        justificante.save!
      end
      flash[:success] = "El justificante se ha editado correctamente"
      redirect_to(justificantes_path)
    else
      flash[:error] = "Se ha producido un error editando el justificante"
      render :edit
    end
  end

  def destroy
    justificante.destroy
    redirect_to justificantes_path, notice: I18n.t("El Justificante fue borrado correctamente")
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