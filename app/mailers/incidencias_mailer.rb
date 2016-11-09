class IncidenciasMailer < ActionMailer::Base
  recipients = Usuario.where("incidencias=true and email='javi.villa9@gmail.com'").map(&:email)
  default to: Proc.new { recipients },
    from: "no-reply@gestoriallorens.com"

  def listado_incidencias
    recipients = Usuario.where("incidencias=true and email='javi.villa9@gmail.com'").map(&:email)
    recipients.each do |email|
        IncidenciasMailer.delay.send_incidencias(email)
    end
  end

  def send_incidencias r
     usuario = Usuario.where("email='{r}'").limit(1).pluck(:id)
     clientes = Usuario.find(usuario).clientes.pluck(:id)
     @incidencias = Transferencia.where("clientes IN (?) AND has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",clientes,true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
     mail to: r, subject: t( "Incidencias vehiculos" )
  end
end