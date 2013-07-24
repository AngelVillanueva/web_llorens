class ContactMailer < ActionMailer::Base
  default from: "gestoriallorens@gestoriallorens.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_confirmation.subject
  #
  def contact_confirmation contact_params
    @contact_params = contact_params

    mail to: "info@sinapse.es", subject: t("Solicitud")
  end
  def agradecimiento contact_params
    mail to: contact_params[:email], subject: t("Confirmado")
  end
end
