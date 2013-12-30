class WeekendMailer < ActionMailer::Base
  recipients = Guardia.all.map(&:email)
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  def new_justificante r
    mail to: r, subject: t( "Solicitud de nuevo justificante" )
  end

  def new_informe r
    mail to: r, subject: t( "Solicitud de nuevo informe" )
  end
end