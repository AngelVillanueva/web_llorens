class InformeTraficosController < ApplicationController
  expose( :informe_traficos ) { current_usuario.informe_traficos }
  expose( :informe_trafico, attributes: :informe_trafico_params )

  def create
    if informe_trafico.save
      flash[:success] = "Nuevo informe creado correctamente"
      redirect_to(informe_traficos_path)
    else
      flash[:error] = "Se ha producido un error creando el informe"
      render :new
    end
  end

  def update
    if informe_trafico.update_attributes!(informe_trafico_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless informe_trafico.pdf_file_name.nil?
        informe_trafico.identificador = informe_trafico.pdf_file_name.gsub(".pdf", "")
        informe_trafico.save!
      end
      flash[:success] = "El informe se ha editado correctamente"
      redirect_to(informe_traficos_path)
    else
      flash[:error] = "Se ha producido un error editando el informe"
      render :edit
    end
  end

  def destroy
    informe_trafico.destroy
    redirect_to informe_traficos_path, notice: I18n.t("El Informe fue borrado correctamente")
  end
  


  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def informe_trafico_params
      if current_usuario
        params
        .require(:informe_trafico)
        .permit!
      end
    end
end
