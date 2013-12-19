class Online::InformesController < OnlineController
  load_and_authorize_resource except: [:new, :create]
  before_filter :authorize_edition, only: :edit
  expose( :informes ) { Informe.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :informe, attributes: :informe_params )

  def index
    respond_to do |format|
      format.html
      format.json { render json: InformesDatatable.new( view_context, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"Informes_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: InformesDatatable.new( view_context, current_ability ).to_csv
      end
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

  def download
    send_file informe.pdf.path, :type => informe.pdf_content_type, :disposition => 'inline'
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

    def authorize_edition
      unless current_usuario.role?("employee") || current_usuario.role?("admin")
        redirect_to root_path, flash: { :alert => "No autorizado" }
      end
    end
end
