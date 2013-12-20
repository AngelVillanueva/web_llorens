class Online::JustificantesController < OnlineController
  load_and_authorize_resource except: [:new, :create]
  before_filter :authorize_edition, only: :edit
  expose( :justificantes ) { Justificante.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :justificante, attributes: :justificante_params )


  def index
    respond_to do |format|
      format.html
      format.json { render json: JustificantesDatatable.new( view_context, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"Justificantes_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: JustificantesDatatable.new( view_context, current_ability ).to_csv
      end
    end
  end

  def create
    if justificante.save
      flash[:success] = "Nuevo justificante creado correctamente"
      redirect_to(online_justificantes_path)
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
      redirect_to(online_justificantes_path)
    else
      flash[:error] = "Se ha producido un error editando el justificante"
      render :edit
    end
  end

  def destroy
    justificante.destroy
    redirect_to online_justificantes_path, notice: I18n.t("El Justificante fue borrado correctamente")
  end

  def download
    send_file justificante.pdf.path, :type => justificante.pdf_content_type, :disposition => 'inline'
  end

  private
  def justificante_params
    if current_usuario
      params
        .require( :justificante )
        .permit!
    end
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin")
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end
end