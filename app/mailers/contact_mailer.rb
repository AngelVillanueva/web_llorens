class ContactMailer < ActionMailer::Base
  if Rails.env.production?
    recipients = [ "jbrugada@gestoriallorens.com" ]
  elsif Rails.env.test?
    recipients = [ "employee@llorens.com" ]
  else
    recipients = [ "javi.villa9@gmail.com" ]
  end
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_confirmation.subject
  #
  def contact_confirmation contact_params, r
    @contact_params = contact_params
    if contact_params[:acepta_privacidad]
      @privacidad = t("Privacidad ok")
    else
      @privacidad = t("Privacidad no ok")
    end

    mail to: r, subject: t("Solicitud")
  end
  def agradecimiento contact_params
    mail to: contact_params[:email], subject: t("Confirmado")
  end
end
