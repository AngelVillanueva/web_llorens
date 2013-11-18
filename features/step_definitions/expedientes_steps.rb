Given(/^there are more Expedientes from other Clientes$/) do
  other_cliente = Cliente.create( nombre: "Other C", identificador: "CCC", cif: "00000000T", llorens_cliente_id: "444999111", organizacion_id: 2 )
  other_expediente = FactoryGirl.create( :matriculacion, matricula:  "Other matricula", cliente: other_cliente )
end

Given(/^there are more Expedientes from other Clientes with matricula PDF$/) do
  step "there are more Expedientes from other Clientes"
  step "some of my Matriculaciones have a matricula pdf"
end

Given(/^there are some Expedientes without matricula$/) do
  matriculacion = FactoryGirl.create( :matriculacion, matricula: nil)
end

Given(/^one new Transferencia was created yesterday$/) do
  y_transferencia = FactoryGirl.create(:transferencia, matricula: "Test yesterday", cliente: cliente, fecha_alta: 1.day.ago )
end

Given(/^my Organizacion has many Matriculaciones$/) do
  the_org = Organizacion.first
  new_cliente = FactoryGirl.create(:cliente, organizacion: the_org)
  m1 = FactoryGirl.create(:matriculacion, cliente: new_cliente)
  m2 = FactoryGirl.create(:matriculacion, cliente: new_cliente)
end

Given(/^the pdf file is not in the server due to any reason$/) do
  m = Matriculacion.first
  m.pdf_file_name = "non-existent.pdf"
  m.save!
end

Given(/^they are older than the chosen date$/) do
  m = Matriculacion.first
  m.created_at = Matriculacion.matriculable_pdf_date.to_time
  m.save!
end

When(/^I submit all the information for a new Expediente$/) do
  visit new_expediente_path
  fill_in "Identificador", with: "IM1"
  fill_in "Organization", with: Usuario.last.organizacion_id
  click_button "Crear Expediente"
end

When(/^I access the page for the first Expediente$/) do
  visit online_matriculacion_path Expediente.find_by_matricula( "Test matriculacion" )
end
When(/^I access the page for the second Expediente$/) do
  visit online_matriculacion_path Expediente.find_by_matricula( "Other matricula" )
end

When(/^I filter the Transferencias by the date of yesterday$/) do
  #page.execute_script %Q{ $('#expedientes_range_from_5').trigger("focus") } # activate datetime picker
  #page.execute_script %Q{ $("a.ui-state-default:contains('17')").trigger("click") } # click on day
  #page.execute_script %Q{ $('#expedientes_range_to_5').trigger("focus") } # activate datetime picker
  #page.execute_script %Q{ $("a.ui-state-default:contains('17')").trigger("click") } # click on day
  click_link "filtering"
  fill_in 'expedientes_range_from_5', with: 1.day.ago.strftime("%d/%m/%Y")
  fill_in 'expedientes_range_to_5', with: 1.day.ago.strftime("%d/%m/%Y")
  page.execute_script %Q{ $('#expedientes_range_from_5').trigger("focus") } # activate datetime picker
end

When(/^some PDF is not yet on the server$/) do
  m = Matriculacion.last
  m.identificador = "Not-here"
  m.save!
end

When(/^there is no matricula yet$/) do
  Matriculacion.all.each do |m|
    m.matricula = nil
    m.save!
  end
end

When(/^I access the edit page for a given Matriculacion$/) do
  visit edit_online_matriculacion_path(Matriculacion.first)
end

When(/^I access the add pdf page for a given Matriculacion$/) do
  visit edit_online_matriculacion_path(Matriculacion.first)
end

When(/^I want to add a PDF for those Matriculaciones$/) do
  visit online_matriculaciones_path
  first( 'a.pdf-add' ).click
end

When(/^some of my Matriculaciones have a matricula pdf$/) do
  the_pdf = File.new( Rails.root.join( 'spec', 'fixtures', 'test-M.pdf' ) )
  m = Matriculacion.first
  m.pdf = the_pdf
  m.save!
end

When(/^I follow their matricula pdf link$/) do
  first('a.pdf-file').click
end

When(/^I visit the matricula PDF page for a Matriculacion of another Cliente$/) do
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00")
  the_pdf = File.new( Rails.root.join( 'spec', 'fixtures', 'test-M.pdf' ) )
  external_matriculacion = FactoryGirl.create( :matriculacion, pdf: the_pdf,
    cliente: acompany )
  visit online_matriculacion_path(external_matriculacion)
end

When(/^I add a PDF for those Matriculaciones$/) do
  visit edit_online_matriculacion_path( Matriculacion.first )
  the_pdf_path = Rails.root.join( 'spec', 'fixtures', 'test-M.pdf' )
  attach_file "matriculacion_pdf", the_pdf_path
  click_button "submit"
end

When(/^I try to add a PDF for those Matriculaciones but fails$/) do
  visit edit_online_matriculacion_path( Matriculacion.first )
  click_button "submit"
end

Then(/^I should see a list of the Expedientes$/) do
  page.should have_title( "Listado de Expedientes" )
  expedientes = Expediente.all.each do |expediente|
    page.should have_selector( 'td', text: expediente.matricula )
  end
end

Then(/^I should see just the Transferencia created yesterday$/) do
  page.should have_selector( 'td', text: "Test yesterday".upcase )
  page.should have_selector( 'tr.expediente', count: 1 )
end

Then(/^I should see a list of the Matriculaciones$/) do
  page.should have_title( "Listado de Matriculaciones" )
  matriculaciones = Matriculacion.all.each do |matriculacion|
    page.should have_selector( 'td', text: matriculacion.matricula.upcase )
  end
end

Then(/^I should see a list of the Transferencias$/) do
  page.should have_title( "Listado de Transferencias" )
  transferencias = Transferencia.all.each do |transferencia|
    page.should have_selector( 'td', text: transferencia.matricula.upcase )
  end
end

Then(/^a new Expediente should be created$/) do
  Expediente.count.should eql( 1 )
end

Then(/^I should just see the list of my Expedientes$/) do
  page.should have_content( "Test matricula".upcase )
  page.should_not have_content( "Other matricula".upcase )
end

Then(/^I should see all the Matriculaciones from my Organizacion$/) do
  rows = Organizacion.first.expedientes.count
  page.should have_selector( 'tr.expediente', count: rows )
end

Then(/^I should (not )?see a detail of that Expediente$/) do |negation|
  if negation
    page.should have_css( '.alert-alert' )
  else
    page.should have_css( 'h1', "Expediente para #{Expediente.first.matricula}" )
    page.should have_selector( 'iframe.pdf' )
  end
end

Then(/^I should see "(.*?)" instead of the link to the PDF$/) do |arg1|
  visit online_matriculaciones_path
  page.should have_selector( 'td', text: "PDF pendiente" )
end

Then(/^I should (not )?see a link to "(.*?)" the Matriculaciones PDF$/) do |negation, action|
  if negation
    page.should_not have_css( "a.pdf-#{action}" )
  else
    page.should have_css( "a.pdf-#{action}" )
  end
end

Then(/^I should be able to add the Matriculacion PDF$/) do
  page.should have_title( I18n.t( "add_matricula_PDF" ) )
  page.should have_selector( 'h2', text: I18n.t( "add_matricula_PDF" ) )
  page.should have_selector( 'div.tools li', count: 2 )
  page.should_not have_content( I18n.t( "PDF actual" ) )
  page.should have_selector( 'input[type=file]' )
  submit_value = I18n.t( "Subir PDF" )
  xpath = "//input[@value='#{submit_value}']"
  page.should have_xpath(xpath)
end

Then(/^I should be able to edit the Matriculacion$/) do
  m = Matriculacion.first
  m.pdf_file_name = "el_pdf.pdf"
  m.save!
  visit edit_online_matriculacion_path(m)
  page.should have_title( I18n.t( "Editar matriculacion" ) )
  page.should have_selector( 'h2', text: I18n.t( "Editar matriculacion" ) )
  page.should have_selector( 'div.tools li', count: 2 )
  page.should have_content( I18n.t( "PDF actual" ) )
  page.should have_selector( 'input[type=file]' )
  submit_value = I18n.t( "Subir PDF" )
  xpath = "//input[@value='#{submit_value}']"
  page.should have_xpath(xpath)
end

Then(/^the update should (not )?occur$/) do |negation|
  if negation
    message = I18n.t( "Error editando matriculacion" )
  else
    message = I18n.t( "PDF editado correctamente" )
  end
  page.should have_selector( '.alert', text: message )
  current_path.should eql online_matriculaciones_path
end

Then(/^the Matriculacion should (not )?be linked to that PDF$/) do |negation|
  m = Matriculacion.first
  unless negation
    m.pdf_file_name.should eql( "test-M.pdf" )
  else
    m.pdf_file_name.should eql nil
  end
end

Then(/^I should (not )?see a link to the matricula PDF$/) do |negation|
  destination = Matriculacion.first.pdf.url
  unless negation
    page.should have_selector( 'a.pdf-file' )
  else
    page.should_not have_css( 'a.pdf-file' )
  end
end