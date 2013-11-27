class WebPagesController < ApplicationController

  def home
  end
  def contact
    counter = contact_params(params).count
    if counter > 0
      contact_data = contact_params(params)
      if contact_data.count == 6
        send_contact_emails contact_data
        redirect_to root_path, notice: "Solicitud enviada correctamente"
      else
        flash[:error] = "Complete todos los campos, por favor"
        render :contact
      end
    elsif request.post? && counter == 0 
      flash[:error] = "Complete todos los campos, por favor"
      redirect_to contact_path
    end
  end
  def download
  end
  def condiciones
  end
  def privacidad
  end
  def cookies_policy
  end

  private
  def contact_params params
    contact_params = {}
    contact_params[:nombre] = params[:inputName]
    contact_params[:email] = params[:inputEmail]
    contact_params[:telefono] = params[:inputPhone]
    contact_params[:ciudad] = params[:inputCity]
    contact_params[:mensaje] = params[:inputComment]
    contact_params[:acepta_privacidad] = params[:inputTOS]
    clean contact_params
  end
  def clean params
    params.each do |k,v|
      if params[k].nil? || params[k].empty?
        params.delete(k)
      end
    end
    params
  end
  def send_contact_emails contact_data
    if current_usuario.role?("admin")
      ContactMailer.delay.contact_confirmation(contact_data)
      ContactMailer.delay.agradecimiento(contact_data)
    else
      ContactMailer.contact_confirmation(contact_data).deliver
      ContactMailer.agradecimiento(contact_data).deliver
    end
  end
end