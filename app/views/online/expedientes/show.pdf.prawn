# load pdf template from Llorens repository
case expediente.type
when "Matriculacion"
  folder = "TU-MATRICULACIONES/"
when "Transferencia"
  folder = "TR-TRANSFERENCIAS/"
else
  folder = ""
end
template_pdf = "#{Rails.root}/app/assets/pdfs/expedientes/#{folder}#{expediente.identificador}.pdf"
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
    pdf.text "No se ha encontrado el documento"
  end
end
