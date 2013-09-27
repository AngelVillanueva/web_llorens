class WebPagesController < ApplicationController
  before_filter :set_cookie_if_js_cookie_is_set

  def home
  end
  def contact
    if contact_params(params).count > 0
      contact_data = contact_params(params)
      if contact_data.count == 5
        #ContactMailer.delay.contact_confirmation(contact_data)
        #ContactMailer.delay.agradecimiento(contact_data)
        ContactMailer.contact_confirmation(contact_data).deliver
        ContactMailer.agradecimiento(contact_data).deliver
        redirect_to root_path, notice: "Solicitud enviada correctamente"
      else
        flash[:error] = "Complete todos los campos, por favor"
        render :contact
      end
    end
  end
  def download
  end

  def cookies_accept
    accept_cookies #this calls the threepwood method to allow cookies
    redirect_to root_path
  end
  def cookies_deny
    #reject_cookies # this calls the threepwood method to remove the fact that the user has accepted cookies
    redirect_to root_path
  end

  private
  def contact_params params
    contact_params = {}
    contact_params[:nombre] = params[:inputName]
    contact_params[:email] = params[:inputEmail]
    contact_params[:telefono] = params[:inputPhone]
    contact_params[:ciudad] = params[:inputCity]
    contact_params[:mensaje] = params[:inputComment]
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
  def set_cookie_if_js_cookie_is_set
    if js_cookie_is_set
      unless @accepted_cookies
        accept_cookies # threepwood gem method
      end
    end
  end
  def js_cookie_is_set name="DCKPLCY"
    cookies[name]
  end
end