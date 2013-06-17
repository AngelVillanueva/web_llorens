class Online::InformesController < OnlineController
  respond_to :html, :json, :js
  
  expose( :informes ) do
    if params[:after]
      timing = Time.at(params[:after].to_i + 1)
      current_usuario.organizacion.informes.where("created_at > ?", timing)
    else
      current_usuario.organizacion.informes
    end
  end
  expose( :informe, attributes: :informe_params )

  def index
    respond_to do |format|
      format.html { informes }
      format.json { render json: informes_for_table(informes) }
      format.js
    end
  end

  def create
    if informe.save
      flash[:success] = "Nuevo informe creado correctamente"
      redirect_to(online_informes_path)
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
      redirect_to(online_informes_path)
    else
      flash[:error] = "Se ha producido un error editando el informe"
      render :edit
    end
  end

  def destroy
    informe.destroy
    redirect_to online_informes_path, notice: I18n.t("El Informe fue borrado correctamente")
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
    def informes_for_table informes
      data = {}
      data[:sEcho] = 1
      data[:iTotalRecords] = informes.count
      data[:iTotalDisplayRecords] = informes.count
      data[:aaData] = format_data informes
      data
    end
    def format_data informes
      informes.map do |informe|
        [
          informe.organizacion.nombre,
          informe.matricula,
          informe.solicitante,
          informe.created_at.strftime("%d/%m/%Y %H:%M"),
          informe.created_at.to_i,
          informe.pdf_file_name.nil? && t("En curso") || t('Si'),
          "pend",
          "link"
        ]
      end
    end
end
