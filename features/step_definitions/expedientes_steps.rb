Given(/^there are more Expedientes from other Clientes$/) do
  other_cliente = Cliente.create( nombre: "Other C", identificador: "CCC", cif: "00000000T", llorens_cliente_id: "444999111", organizacion_id: 2 )
  other_expediente = FactoryGirl.create( :matriculacion, matricula: "Other matricula", cliente: other_cliente)
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