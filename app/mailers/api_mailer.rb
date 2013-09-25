class ApiMailer < ActionMailer::Base
  default from: "gestoriallorens@gestoriallorens.com"

  def api_error response_block
    @response = response_block

    mail to: "info@sinapse.es", subject: t("Error creando Expedientes")
  end
end
