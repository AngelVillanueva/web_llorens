class ContactMailer < ActionMailer::Base
  default from: "gestoriallorens@gestoriallorens.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_confirmation.subject
  #
  def contact_confirmation
    @greeting = "Hi"

    mail to: "info@sinapse.es", subject: "Solicitud de informacion recibida"
  end
end
