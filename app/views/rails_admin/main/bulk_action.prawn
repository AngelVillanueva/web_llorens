clase = params[:model_name].camelize.constantize
selected = clase.find(params[:bulk_ids])

prawn_document do |pdf|
  pdf.text clase.to_s.pluralize.upcase, :style => :bold, :size => 16
  pdf.move_down 20
  selected.each_with_index do |objeto, index|
    case clase.to_s
    when "Justificante"
      per_page = 3
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
      pdf.text "Hora solicitud: " + I18n.l(objeto.hora_solicitud, format: "%d/%m/%Y %H:%S") unless objeto.hora_solicitud.nil?
      pdf.text "Hora entrega: " + I18n.l(objeto.hora_entrega, format: "%d/%m/%Y %H:%S") unless objeto.hora_entrega.nil?
      if objeto.hora_entrega.nil?
        pdf.text "Estado: pendiente"
      else
        pdf.text "Estado: finalizado"
      end
    when "Informe"
      per_page = 7
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
    pdf.text "-----------------------------------"
    if (index + 1) % per_page == 0
      pdf.start_new_page if index +1 < selected.count
    end
  end
  string = "página <page> de <total>"
  # Green page numbers 1 to 11
    options = { :at => [pdf.bounds.right - 150, 0],
     :width => 150,
     :align => :right,
     :page_filter => (1..11),
     :start_count_at => 1,
     :color => "0088cc" }
  pdf.number_pages string, options
end