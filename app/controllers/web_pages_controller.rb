class WebPagesController < ApplicationController

  def home
  end
  def contact
    if params[:inputName]
      ContactMailer.contact_confirmation.deliver
      redirect_to root_path, notice: "Solicitud enviada correctamente"
    end
  end
  def download
  end
end