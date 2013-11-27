class WeekendMailer < ActionMailer::Base
  recipients = Guardia.all.map(&:email)
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  def new_justificante
    mail subject: t( "Solicitud de nuevo justificante" )
  end
end