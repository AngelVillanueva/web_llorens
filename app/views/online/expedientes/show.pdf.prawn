# load pdf template from Llorens repository via helper
base_pdf = llorens_base_pdf expediente # llorens_base_pdf is a custom helper

# if the pdf exists render it skipping the first page
if File.exist? base_pdf
  # create temporary pdf file without first page with RGhost via a custom model TmpPdf
    initial_page = 2 # skip 1st page
    temporary = TmpPdf.new( base_pdf, initial_page ).path
  # def pdf output via prawn
  prawn_document( template: temporary ) do |pdf|
    pdf
    File.delete temporary
  end
else
  # pdf not in the server, show an advise and the searched path if admin
  prawn_document do |pdf|
    if current_usuario.role? "admin"
      pdf.text "No se ha encontrado el documento #{base_pdf}"
    else
      pdf.text "No se ha encontrado el documento"
    end
  end
end
