class ApiMailer < ActionMailer::Base
  if Rails.env.production?
    recipients = ["info@sinapse.es"]
  else
    recipients = ["info@sinapse.es"]
  end
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  def api_error_message response_block
    @response = response_block
    subject = t("Error creando Expedientes")

    mail subject: subject
  end
end
