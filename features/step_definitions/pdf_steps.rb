When(/^I follow a PDF link$/) do
  click_link "Ver PDF"
end

Then (/^I should (not )?see a PDF document$/) do |negation|
  if negation
    page.source.force_encoding('BINARY').should_not =~ /%PDF-1./
  else
    page.source.force_encoding('BINARY').should =~ /%PDF-1./
  end
end

Then /^the PDF should be the one for the related Item$/ do
  content = parse_pdf_content(parse_pdf(page.source))
  content.should have_content("Smarty Manual")
end

Then /^the first page from the original PDF should not appear$/ do
  the_pdf = parse_pdf(page.source)
  content = parse_pdf_content(parse_pdf(page.source))
  the_pdf.page_count.should == 2  # sample document has 3 pages
  parse_pdf_content(parse_pdf(page.source)).should_not have_content("Monte Ohrt") # content for the first page in the original sample PDF
  content.should have_content("publicado 07-10-2004") # content for the second page in the original sample PDF
  content.should have_content("Tabla de contenidos") # content for the third page in the original sample PDF
end

private
def parse_pdf source
  reader_object = PDF::Reader.new(StringIO.new(source))
end
def parse_pdf_content pdf
  pages = Array.new
  content = pdf.pages.collect(&:text).join("\n")
end
