clase = params[:model_name].camelize.constantize
objeto = clase.find(params[:id])

prawn_document do |pdf|
  pdf.text clase.to_s.upcase, :style => :bold, :size => 16
  case clase.to_s
  when "Justificante"
    pdf.text "Cliente: " + objeto.cliente.nombre.to_s
    pdf.text "Matricula: " + objeto.matricula.to_s
    pdf.text "Bastidor: " + objeto.bastidor.to_s
    pdf.text "NIF-CIF: " + objeto.nif_comprador.to_s
    pdf.text "Nombre o Razon Social: " + objeto.nombre_razon_social.to_s
    pdf.text "Municipio: " + objeto.municipio.to_s
    pdf.text "Provincia: " + objeto.provincia.to_s
    pdf.text "Direccion: " + objeto.direccion.to_s
    pdf.text "Marca: " + objeto.marca.to_s
    pdf.text "Modelo: " + objeto.modelo.to_s
    pdf.text "Hora solicitud: " + I18n.l(objeto.hora_solicitud, format: :short) unless objeto.hora_solicitud.nil?
    pdf.text "Hora entrega: " + I18n.l(objeto.hora_entrega, format: :short) unless objeto.hora_entrega.nil?
  else
    pdf.text clase.to_s + " no existe"
  end
end