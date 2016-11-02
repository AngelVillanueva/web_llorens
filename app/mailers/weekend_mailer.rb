@class WeekendMailer < ActionMailer::Base
  recipients = Guardia.all.map(&:email)
  default to: Proc.new { recipients },
    from: "gestoriallorens@gestoriallorens.com"

  def new_justificante r, cliente
    @cliente_nombre = cliente.nombre
    mail to: r, subject: t( "Solicitud de nuevo justificante" )
  end

  def new_mandato r, cliente
    @cliente_nombre = cliente.nombre
    mail to: r, subject: t( "Solicitud de nuevo mandato" )
  end

  def new_informe r, cliente
    @cliente_nombre = cliente.nombre
    mail to: r, subject: t( "Solicitud de nuevo informe" )
  end
end