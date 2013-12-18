class Online::ExpedientesController < OnlineController
  load_and_authorize_resource
  before_filter :authorize_edition, only: :edit
  #expose( :expedientes ) { Expediente.accessible_by( current_ability ) }
  expose( :expedientes ) { expediente_type.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :expediente_type ) { params[:type].constantize }
  expose( :expediente, attributes: :expediente_params )

  def index
    respond_to do |format|
      format.html
      format.json { render json: ExpedientesDatatable.new( view_context, expediente_type, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"#{expediente_type}_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: ExpedientesDatatable.new( view_context, expediente_type, current_ability ).to_csv
      end
    end
  end

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if expediente.update_attributes!(expediente_params_pdf)
      flash[:success] = I18n.t( "PDF editado correctamente" )
      redirect_to(online_matriculaciones_path)
    else
      flash[:error] = I18n.t( "Error editando matriculacion" )
      render :edit
    end
  end

  def matricula
    send_file expediente.pdf.path, :type => expediente.pdf_content_type, :disposition => 'inline'
  end

  # custom rescue from strong parameters parameter missing
  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    flash[:error] = I18n.t( "Error editando matriculacion" )
    redirect_to(online_matriculaciones_path)
  end

  

  private
  def expediente_params
    # params
    #   .require( :expediente )
    #   .permit( :identificador, :matricula )
  end
  def expediente_params_pdf
    params
      .require( :matriculacion )
      .permit( :pdf )
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin")
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end

end