pdf = Prawn::Document.new
pdf.image "#{Rails.root}/app/assets/images/theme/mandato_logo.jpg", :width => 200, :height => 50, :position => :center
pdf.font "Helvetica"
pdf.font_size = 8
pdf.move_down 40
pdf.text "Don Jaime Brugada Casula con DNI 46130068 en representación de #{@mandato.nombre_razon_social}, con C.I.F #{@mandato.nif_comprador} , y domicilio legal en #{@mandato.provincia} , calle #{@mandato.direccion} , en concepto de <b>MANDANTE</b>:", :inline_format => true 
pdf.move_down 20
pdf.text "<b><u>Dice y otorga:</u></b>", :inline_format => true
pdf.move_down 20
pdf.text "Que confiere <b>MANDATO CON REPRESENTACIÓN</b>, que se regirá por los arts. 1.709 a 1.739 del Código Civil, a favor de <b>D PATRICIA BRUGADA CASULA</b>, Gestor Administrativo en ejercicio, perteneciente al Colegio Oficial de Gestores Administrativos de <b>CATALUNYA</b>, en concepto de <b>MANDATARIO</b>.", :inline_format => true 
pdf.move_down 20
pdf.text  "Que el presente MANDATO se confiere al amparo del art. 32.1 de la Ley 30/1992, de 26 de noviembre, de Régimen Jurídico de las Administraciones Públicas y del Procedimiento Administrativo Común (LRJAP), y del artículo 1 del Estatuto Orgánico de la Profesión de Gestor Administrativo, aprobado por Decreto 424/1963, para que promueva, solicite y realice toda clase de trámites, en relación con el asunto siguiente:"
pdf.move_down 20
pdf.text "#{@mandato.matricula_bastidor}"
pdf.move_down 20
pdf.text "Que el presente MANDATO incluye las actuaciones contenidas en el art. 32.3 de la LRJAP, es decir, formular solicitudes, entablar recursos, desistir de acciones y renunciar a derechos."
pdf.move_down 20
pdf.text "Que el presente MANDATO se confiere para su actuación ante todos los órganos y entidades de la Administración del Estado, Autonómica y Local que resulten competentes, en relación con los trámites del asunto referenciado, y específicamente ante la Jefatura Provincial de Tráfico."
pdf.move_down 20
pdf.text "Que el presente MANDATO mantendrá su vigencia mientras no sea expresamente revocado y comunicada fehacientemente su revocación al mandatario."
pdf.move_down 20
pdf.text "Que declara bajo su responsabilidad que entrega al Gestor Administrativo los documentos necesarios y exigidos por la normativa vigente, que son auténticos y su contenido enteramente correcto."
pdf.move_down 20
pdf.text "Que asimismo autoriza al mandatario para que nombre sustituto para la tramitación del asunto en caso de necesidad justificada, siempre a favor de un Gestor Administrativo en ejercicio."
pdf.move_down 20
pdf.text "Que conoce y acepta que los datos que se suministran por medio del presente MANDATO se incorporarán a unos ficheros automatizados de datos, de los que son responsables el Gestor Administrativo al que se le otorga el mandato y el Colegio Oficial de Gestores Administrativos de <b>CATALUNYA</b>, con objeto de posibilitar la eficaz prestación de sus servicios profesionales y, en su caso, el servicio canalizado de presentación de documentos, pudiendo ejercitar los derechos de acceso, cancelación y rectificación, de conformidad con la Ley Orgánica 15/1999, de 13 de diciembre.
", :inline_format => true 
pdf.move_down 20
pdf.text "En                         a #{@fecha}", :align => :center
pdf.text "EL MANDANTE", :align => :center
pdf.move_down 40
pdf.text "Acepto EL MANDATO y declaro bajo mi responsabilidad que los documentos recibidos del mandante han sido verificados y son correctos los datos contenidos en los mismos."
pdf.move_down 20
pdf.text "En                         a #{@fecha}", :align => :center
pdf.text "EL MANDATARIO", :align => :center
pdf.move_down 20
pdf.text "Gestor Administrativo", :align => :center
pdf.text "Nº de colegiado <b>3191</b>", :inline_format => true, :align => :center 

pdf.start_new_page
pdf.font_size = 18
pdf.text "DOCUMENTO DE REPRESENTACIÓN DE PERSONAS JURÍDICAS", :inline_format => true, :align => :center
pdf.stroke_color "000000"
pdf.stroke do
 	# just lower the current y position
 	pdf.move_down 10
 	pdf.horizontal_rule
end

pdf.move_down 40
pdf.font_size = 12
pdf.text "En cumplimiento de lo establecido en el Anexo XIII letra A) 3º del Reglamento General de Vehículos (RD 2822/1998, de 23 de Diciembre), y a los efectos de su presentación ante la Jefatura Provincial local de Trafico de BARCELONA, el/los abajo firmantes declara/declaran tener poder suficiente para actuar en nombre y representación de la entidad:"
pdf.move_down 20
pdf.text " #{@mandato.nombre_razon_social}"
pdf.move_down 10
pdf.text "con CIF nº #{@mandato.nif_comprador}, para la tramitación del expediente del vehículo"
pdf.move_down 10
pdf.text "con matrícula/bastidor: #{@mandato.matricula_bastidor}"
pdf.move_down 20
pdf.text "Y para que así conste y surta los efectos oportunos,"
pdf.move_down 20
pdf.text "En                                  a #{@fecha}"
pdf.move_down 50
pdf.text "     <u>NOMBRE Y APELLIDOS</u>                                   <u>DNI</u>", :inline_format => true
pdf.move_down 10
pdf.text "       #{@mandato.repre_nombre} #{@mandato.repre_apellido_1} #{@mandato.repre_apellido_2}                                      #{@mandato.nif_representante}"
pdf.move_down 50
pdf.font_size = 14
pdf.text "Firma:"

file_path = "#{Rails.root}/app/assets/pdfs/mandatos/mandato_sociedades_#{mandato.identificador}.pdf"  
pdf.render_file file_path
File.open(file_path)
