class InformesController < ApplicationController
  expose( :informes ) { current_usuario.organizacion.informes }
  expose( :informe, attributes: :informe_params )

  def create
    if informe.save
      flash[:success] = "Nuevo informe creado correctamente"
      redirect_to(informes_path)
    else
      flash[:error] = "Se ha producido un error creando el informe"
      render :new
    end
  end

  def update
    if informe.update_attributes!(informe_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless informe.pdf_file_name.nil?
        informe.identificador = informe.pdf_file_name.gsub(".pdf", "")
        informe.save!
      end
      flash[:success] = "El informe se ha editado correctamente"
      redirect_to(informes_path)
    else
      flash[:error] = "Se ha producido un error editando el informe"
      render :edit
    end
  end

  def destroy
    informe.destroy
    redirect_to informes_path, notice: I18n.t("El Informe fue borrado correctamente")
  end
  


  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def informe_params
      if current_usuario
        params
        .require(:informe)
        .permit!
      end
    end
end
