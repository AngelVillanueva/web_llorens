# load pdf template from Llorens repository
if Rails.env.production?
  template_pdf = "#{shared_path}/assets/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
else
  template_pdf = "#{Rails.root}/app/assets/pdfs/expedientes/#{folder_name(expediente.type)}#{expediente.identificador}.pdf"
end
# if the pdf exists render it skipping the first page
if File.exist? template_pdf
  # calculate page range skipping first page
  page = 2
  final_page = PDF::Reader.new(template_pdf).page_count + 1
  # create temporary pdf file without first page with RGhost
  temporary = RGhost::Convert.new(template_pdf)
  modified = temporary.to :pdf, filename: "#{Rails.root}/app/testing.pdf", range: 2..final_page
  # def pdf output via prawn
  prawn_document( template: modified ) do |pdf|
    pdf
    File.delete modified
  end
else
  prawn_document do |pdf|
    if current_usuario.role? "admin"
      pdf.text "No se ha encontrado el documento #{template_pdf}"
    else
      pdf.text "No se ha encontrado el documento"
    end
  end
end
