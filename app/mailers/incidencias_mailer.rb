class IncidenciasMailer < ActionMailer::Base
  recipients = Usuario.where("incidencias=true").map(&:email)
  default to: Proc.new { recipients },
    from: "no-reply@gestoriallorens.com"

  def listado_incidencias
    recipients = Usuario.where("incidencias=true").map(&:email)
    recipients.each do |email|
        IncidenciasMailer.delay.send_incidencias(email)
    end
  end

  def send_incidencias r
    if Usuario.exists?(:email => r)
      usuario = Usuario.find_by_email(r);
      unless usuario.role?("employee") || usuario.role?("admin")
        clientes = usuario.norole? && usuario.organizacion.clientes.pluck(:id) || Cliente.pluck(:id)
        @incidencias = Transferencia.where("cliente_id IN (?) AND has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",clientes,true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
      else
        @incidencias = Transferencia.where("has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
      end
    end
    unless @incidencias.nil? && @incidencias.empty?
      mail to: r, subject: t( "Incidencias vehiculos" )
    end
  end
end