class WebPagesController < ApplicationController

  def home
  end
  def contacto
    if params
      ContacMailer.contact_confirmation.deliver
      redirect_to root_path, notice: "Solicitud enviada correctamente"
    end
  end
  def download
  end
end