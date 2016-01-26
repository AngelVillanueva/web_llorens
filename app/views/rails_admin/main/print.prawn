clase = params[:model_name].camelize.constantize
objeto = clase.find(params[:id])

prawn_document do |pdf|
  pdf.text clase.to_s.upcase, :style => :bold, :size => 16
  case clase.to_s
  when "Justificante"
    pdf.text "Cliente: " + objeto.cliente.nombre.to_s
    pdf.text "Matricula: " + objeto.matricula.upcase.to_s
    pdf.text "Bastidor: " + objeto.bastidor.to_s
    pdf.text "NIF-CIF: " + objeto.nif_comprador.to_s
    pdf.text "Nombre o Razon Social: " + objeto.nombre_razon_social.to_s
    unless objeto.primer_apellido.to_s.empty? && objeto.segundo_apellido.to_s.empty?
      pdf.text "Apellidos: " + objeto.primer_apellido.to_s + ' ' + objeto.segundo_apellido.to_s
    end
    pdf.text "Municipio: " + objeto.municipio.to_s
    pdf.text "Codigo Postal: " + objeto.codpostal.to_s
    pdf.text "Provincia: " + objeto.provincia.to_s
    pdf.text "Direccion: " + objeto.direccion.to_s
    pdf.text "Marca: " + objeto.marca.to_s
    pdf.text "Modelo: " + objeto.modelo.to_s
    pdf.text "Hora solicitud: " + I18n.l(objeto.hora_solicitud, format: "%d/%m/%Y %H:%M") unless objeto.hora_solicitud.nil?
    pdf.text "Hora entrega: " + I18n.l(objeto.hora_entrega, format: "%d/%m/%Y %H:%M") unless objeto.hora_entrega.nil?
    if objeto.hora_entrega.nil?
      pdf.text "Estado: pendiente"
    else
      pdf.text "Estado: finalizado"
    end
  when "Informe"
    pdf.text "Cliente: " + objeto.cliente.nombre.to_s
    pdf.text "Matricula: " + objeto.matricula.upcase.to_s
    pdf.text "Solicitante: " + objeto.solicitante.to_s
    pdf.text "Fecha solicitud: " + I18n.l(objeto.created_at, format: "%d/%m/%Y")
    if objeto.pdf_file_name.nil?
      pdf.text "Estado: pendiente"
    else
      pdf.text "Estado: finalizado"
    end
    # no vale la pena complicarlo tanto porque luego hay que adaptarlo a cada caso
    # objeto.attributes.each do |attr_name, attr_value|
    #   if attr_name.to_s.in? %w[cliente matricula solicitante created_at]
    #     pdf.text attr_name.to_s.capitalize + ": " + attr_value.to_s
    #   end
    # end
    # pdf.text objeto.attributes["matricula"].to_s
  else
    pdf.text clase.to_s + " no existe o no puede imprimirse."
  end
end