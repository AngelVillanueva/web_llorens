class IncidenciasMailer < ActionMailer::Base
  recipients = Usuario.where("incidencias=true").map(&:email)
  default to: Proc.new { recipients },
    from: "no-reply@gestoriallorens.com"

  def listado_incidencias
    recipients = Usuario.where("incidencias=true").map(&:email)
    @incidencias = Transferencia.where("has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
    recipients.each do |email|
        mail to: email, subject: t( "Incidencias vehiculos" )
    end
  end
end