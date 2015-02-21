class Online::MandatosController < OnlineController
  load_and_authorize_resource except: [:new, :create]
  before_filter :authorize_edition, only: :edit
  expose( :avisos ) { current_usuario.avisos.vivos }
  expose( :mandatos ) { Mandato.scoped.accessible_by( current_ability ).page( params[ :page ] ).per( 10 ) }
  expose( :mandato, attributes: :mandato_params )


  def index
    respond_to do |format|
      format.html
      format.json { render json: MandatosDatatable.new( view_context, current_ability ) }
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=\"Mandatos_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.csv\""
        render text: MandatosDatatable.new( view_context, current_ability ).to_csv
      end
      format.xls do
        xls_name = "Mandatos_Llorens_#{Time.now.strftime("%d_%m-%Y_%H-%M-%S")}.xls"
        send_data MandatosDatatable.new( view_context, current_ability ).to_csv(col_sep: "\t"), type: "text/xls; header=present", disposition: "attachment; filename=#{xls_name}", filename: xls_name
      end
    end
  end

  def create
    if mandato.save
      flash[:success] = "Nuevo mandato creado correctamente"
      redirect_to(online_mandatos_path)
    else
      flash[:error] = "Se ha producido un error creando el mandato"
      render :new
    end
  end

  def update
    if mandato.update_attributes!(mandato_params)
      # el identificador se hace coincidir con el nombre del pdf si se ha incluido
      unless mandato.pdf_file_name.nil?
        mandato.identificador = mandato.pdf_file_name.gsub(".pdf", "")
        mandato.save!
      end
      flash[:success] = "El mandato se ha editado correctamente"
      redirect_to(online_mandatos_path)
    else
      flash[:error] = "Se ha producido un error editando el mandato"
      render :edit
    end
  end

  def destroy
    mandato.destroy
    redirect_to online_mandatos_path, notice: I18n.t("El Mandato fue borrado correctamente")
  end

  def download
    send_file mandato.pdf.path, :type => mandato.pdf_content_type, :disposition => 'inline'
  end

  def view_validator
    unless mandato.pending_code
      redirect_to online_mandatos_path, notice: I18n.t("Este codigo ya ha sido validado")
    else
      respond_to do |format|
        format.js { render :layout => false, :locals => { :id => mandato.id } }
      end
    end
  end

  def send_sms
    if mandato.pending_code
      # Get your Account Sid and Auth Token from twilio.com/user/account
      account_sid = 'ACb4d827668632ab7032dde06ec5d4c674'
      auth_token = '08068717df7c765f3e81ddc0dad5e63c'
      
      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
       
        message = @client.account.messages.create(:body => I18n.t("Su codigo de validacion es") + mandato.secure_token[0..5],
            :to => "+34679514899",     # Replace with your phone number
            :from => "+34986080586")   # Replace with your Twilio number
        puts message.sid
        mandato.count_sms = mandato.count_sms + 1
        mandato.save
        redirect_to online_mandatos_path, notice: I18n.t("Codigo de validacion enviado") + mandato.telefono

      rescue Twilio::REST::RequestError => e
          redirect_to online_mandatos_path, notice: I18n.t("Fallo al enviar el codigo de validacion") + e.message
      end
    else
      redirect_to online_mandatos_path, notice: I18n.t("Este codigo ya ha sido validado")
    end
  end

  def gen_mandato
    @fecha = l(Time.now.to_date, format: :long)
    if mandato.pending_code
      redirect_to online_mandatos_path, notice: I18n.t("No ha introducido el codigo de validacion")
    else
      if mandato.imacompany == true
          mandato.pdf_file_name = "mandato_sociedades_"+mandato.identificador+".pdf"
          mandato.save
          respond_to do |format|
            format.pdf { render :layout => false, :template => 'online/mandatos/gen_mandato_sociedades.pdf.prawn' } 
          end
      else
          mandato.pdf_file_name = "mandato_fisico_"+mandato.identificador+".pdf"
          mandato.save
          respond_to do |format|
            format.pdf { render :layout => false, :template => 'online/mandatos/gen_mandato_fisico.pdf.prawn' }
          end
      end
    end
  end

  private
  def mandato_params
    if current_usuario
      params
        .require( :mandato )
        .permit!
    end
  end
  def authorize_edition
    unless current_usuario.role?("employee") || current_usuario.role?("admin")
      redirect_to root_path, flash: { :alert => "No autorizado" }
    end
  end
end