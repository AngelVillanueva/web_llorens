class ContactMailer < ActionMailer::Base
  if Rails.env.production?
    recipients = ["info@sinapse.es", "jbrugada@gestoriallorens.com"]
  else
    recipients = ["info@sinapse.es"]
  end
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_confirmation.subject
  #
  def contact_confirmation contact_params
    @contact_params = contact_params

    mail subject: t("Solicitud")
  end
  def agradecimiento contact_params
    mail to: contact_params[:email], subject: t("Confirmado")
  end
end
