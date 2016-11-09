class IncidenciasMailer < ActionMailer::Base
  recipients = Usuario.where("incidencias=true and (email='javi.villa9@gmail.com' or email='javier.villanueva@netberry.es')").map(&:email)
  default to: Proc.new { recipients },
    from: "no-reply@gestoriallorens.com"

  def listado_incidencias
    recipients = Usuario.where("incidencias=true and (email='javi.villa9@gmail.com' or email='javier.villanueva@netberry.es')").map(&:email)
    recipients.each do |email|
        IncidenciasMailer.delay.send_incidencias(email)
    end
  end

  def send_incidencias r
     usuario = Usuario.where("email=?",r).limit(1)

     #unless current_usuario.role?("employee") || current_usuario.role?("admin")
        clientes = Usuario.find(usuario.id).clientes.pluck(:id)
        @incidencias = Transferencia.where("clientes IN (?) AND has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",clientes,true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
     #else
     #   @incidencias = Transferencia.where("has_incidencia = ? AND fecha_alta < ? AND fecha_resolucion_incidencia IS NULL",true,Date.today - 5).order("cliente_id asc, fecha_alta asc");
     #end

     mail to: r, subject: t( "Incidencias vehiculos" )
  end
end