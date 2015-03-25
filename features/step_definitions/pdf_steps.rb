Given(/^some of the Expedientes have documents attached$/) do
  exp = Expediente.first
  exp.has_documentos = true
  exp.save!
end

When(/^I follow a PDF link$/) do
  first('tbody tr').click_link "Ver PDF"
end

When(/^I visit the Expediente PDF page for an Expediente of another Cliente$/) do
  step "there are more Expedientes from other Clientes"
  visit online_matriculacion_path Expediente.last, format: 'pdf'
end

When(/^I visit the Justificante PDF page for a Justificante of another Cliente$/) do
  the_pdf = File.new(Rails.root.join('spec', 'fixtures', 'test-J.pdf'))
  step "there are also Justificantes from other Clientes"
  j = Justificante.first
  j.pdf = the_pdf
  j.save!
  visit j.pdf.url
end

When(/^I visit the Mandato PDF page for a Mandato of another Cliente$/) do
  the_pdf = File.new(Rails.root.join('spec', 'fixtures', 'test-MD.pdf'))
  step "there are also Mandatos from other Clientes"
  m = Mandato.first
  m.pdf = the_pdf
  m.save!
  visit m.pdf.url
end

When(/^I visit the Informe PDF page for a Informe of another Cliente$/) do
  the_pdf = File.new(Rails.root.join('spec', 'fixtures', 'test-I.pdf'))
  step "there are also Informes from other Clientes"
  Usuario.count.should eql 1
  Informe.count.should eql 1
  Usuario.first.informes.count.should eql 0
  i = Informe.first
  i.pdf = the_pdf
  i.save!
  visit i.pdf.url
end

Then (/^I should (not )?see a PDF document$/) do |negation|
  if negation
    page.source.force_encoding( 'BINARY' ).should_not =~ /%PDF-1./
  else
    page.source.force_encoding( 'BINARY' ).should =~ /%PDF-1./
  end
end

Then /^the PDF should be the one for the related Item$/ do
  content = parse_pdf_content( parse_pdf( page.source ) )
  content.should have_content( "Smarty Manual" )
end

Then(/^the PDF should be the one for missing document case$/) do
  content = parse_pdf_content( parse_pdf( page.source ) )
  content.should have_content( "No se ha encontrado el documento" )
end

Then /^the first page from the original PDF should not appear$/ do
  the_pdf = parse_pdf( page.source )
  content = parse_pdf_content(parse_pdf( page.source ) )
  the_pdf.page_count.should == 2  # sample document has 3 pages
  parse_pdf_content(parse_pdf( page.source ) ).should_not have_content( "Monte Ohrt" ) # content for the first page in the original sample PDF
  content.should have_content( "publicado 07-10-2004" ) # content for the second page in the original sample PDF
  content.should have_content( "Tabla de contenidos" ) # content for the third page in the original sample PDF
end

private
def parse_pdf source
  reader_object = PDF::Reader.new( StringIO.new( source ) )
end
def parse_pdf_content pdf
  pages = Array.new
  content = pdf.pages.collect( &:text ).join( "\n" )
end
