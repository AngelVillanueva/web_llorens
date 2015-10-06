class Online::DriversController < OnlineController
  load_and_authorize_resource except: [:new, :create]
  before_filter :authorize_edition, only: :edit
  expose( :avisos ) { current_usuario.avisos.vivos }
  expose( :drivers ) { Driver.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :driver, attributes: :driver_params )


  def index
    respond_to do |format|
      format.html
      format.json { render json: DriversDatatable.new( view_context, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"Drivers_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: DriversDatatable.new( view_context, current_ability ).to_csv
      end
      format.xls do
        xls_name = "Drivers_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.xls"
        send_data DriversDatatable.new( view_context, current_ability ).to_csv(col_sep: "\t"), type: "text/xls; header=present", disposition: "attachment; filename=#{xls_name}", filename: xls_name
      end
    end
  end

  def create
    if driver.save
      flash[:success] = "Nuevo driver creado correctamente"
      redirect_to(online_drivers_path)
    else
      flash[:error] = "Se ha producido un error creando el driver"
      render :new
    end
  end

  def update
    if driver.update_attributes!(driver_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless driver.pdf_file_name.nil?
        driver.save!
      end
      flash[:success] = "El driver se ha editado correctamente"
      redirect_to(online_drivers_path)
    else
      flash[:error] = "Se ha producido un error editando el driver"
      render :edit
    end
  end

  def destroy
    driver.destroy
    redirect_to online_drivers_path, notice: I18n.t("El Driver fue borrado correctamente")
  end

  def download
    send_file driver.pdf.path, :type => driver.pdf_content_type, :disposition => 'inline'
  end

  def view_observaciones
    respond_to do |format|
      format.js { render :layout => false, :locals => { :id => driver.id, :documento => driver } }
    end
  end

  private
  def driver_params
    if current_usuario
      params
        .require( :driver )
        .permit!
    end
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin") || current_usuario.has_cli_remarketing?
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end
end