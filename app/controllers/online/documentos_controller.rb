class Online::DocumentosController < OnlineController
  load_and_authorize_resource except: [:new, :create]
  before_filter :authorize_edition, only: :edit
  expose( :avisos ) { current_usuario.avisos.vivos }
  expose( :documentos ) { Documento.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :documento, attributes: :documento_params )


  def index
    respond_to do |format|
      format.html
      format.json { render json: DocumentosDatatable.new( view_context, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"Documentos_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: DocumentosDatatable.new( view_context, current_ability ).to_csv
      end
      format.xls do
        xls_name = "Documentos_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.xls"
        send_data DocumentosDatatable.new( view_context, current_ability ).to_csv(col_sep: "\t"), type: "text/xls; header=present", disposition: "attachment; filename=#{xls_name}", filename: xls_name
      end
    end
  end

  def create
    if documento.save
      flash[:success] = "Nuevo documento creado correctamente"
      redirect_to(online_documentos_path)
    else
      flash[:error] = "Se ha producido un error creando el documento"
      render :new
    end
  end

  def update
    if documento.update_attributes!(documento_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless documento.pdf_file_name.nil?
        documento.save!
      end
      flash[:success] = "El documento se ha editado correctamente"
      redirect_to(online_documentos_path)
    else
      flash[:error] = "Se ha producido un error editando el documento"
      render :edit
    end
  end

  def destroy
    documento.destroy
    redirect_to online_documentos_path, notice: I18n.t("El Documento fue borrado correctamente")
  end

  def download
    send_file documento.pdf.path, :type => documento.pdf_content_type, :disposition => 'inline'
  end

  def downdoc
    if current_usuario.role?("employee") || current_usuario.role?("admin")
      documento.download_pdf = true;
      documento.save!
    end
    send_file documento.pdf.path, :type => documento.pdf_content_type, :disposition => 'inline'
  end

  private
  def documento_params
    if current_usuario
      params
        .require( :documento )
        .permit!
    end
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin") || current_usuario.has_cli_remarketing?
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end
end