template_pdf = "#{Rails.root}/app/assets/pdfs/expedientes/#{expediente.identificador}.pdf"
#template_pdf = open("http://www.gestoriallorens.com/scantrtu/tr/#{expediente.identificador}.pdf")
page = 2
final_page = PDF::Reader.new(template_pdf).page_count + 1

prawn_document( skip_page_creation: true ) do |pdf|
  until page == final_page do
    pdf.start_new_page(template: template_pdf, template_page: page)
    page += 1
  end
end