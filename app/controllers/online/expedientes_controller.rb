class Online::ExpedientesController < OnlineController
  load_and_authorize_resource
  before_filter :authorize_edition, only: :edit
  #expose( :expedientes ) { Expediente.accessible_by( current_ability ) }
  expose( :expedientes ) { expediente_type.scoped.accessible_by( current_ability ) }
  expose( :expediente_type ) { params[:type].constantize }
  expose( :expediente, attributes: :expediente_params )

  def create
    if expediente.save
      redirect_to(expediente)
    else
      render :new
    end
  end

  def edit
  end

  def matricula
    send_file expediente.pdf.path, :type => expediente.pdf_content_type, :disposition => 'inline'
  end

  private
  def expediente_params
    # params
    #   .require( :expediente )
    #   .permit( :identificador, :matricula )
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin")
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end

end