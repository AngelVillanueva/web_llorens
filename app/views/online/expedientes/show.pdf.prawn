require 'rghost'

# load pdf template from Llorens repository via helper
base_pdf = llorens_base_pdf expediente

# if the pdf exists render it skipping the first page
if File.exist? base_pdf
  # calculate page range skipping first page
  pages = range_page_for_pdf base_pdf, 2
  # create temporary pdf file without first page with RGhost
  temporary = RGhost::Convert.new(base_pdf)
  modified = temporary.to :pdf, filename: "#{Rails.root}/app/testing.pdf", range: pages
  # def pdf output via prawn
  prawn_document( template: modified ) do |pdf|
    pdf
    File.delete modified
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
