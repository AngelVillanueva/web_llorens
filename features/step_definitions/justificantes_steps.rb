Given(/^one of the justificantes has an attached PDF$/) do
  justificante = Justificante.find_by_matricula( "Test justificante" )
  justificante.pdf_content_type = "application/pdf"
end

Given(/^there are also Justificantes from other Clientes$/) do
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_justificantes = FactoryGirl.create( :justificante, matricula: "Justificante externo",
    cliente: acompany )
end

Given(/^there are also Justificantes from other Clientes of my Organizacion$/) do
  org = Organizacion.first
  cliente = FactoryGirl.create(:cliente, organizacion: org)
  justificante = FactoryGirl.create(:justificante, cliente: cliente)
end

When(/^I submit all the information for a new Justificante$/) do
  visit new_online_justificante_path
  fill_in "Identificador", with: "AAA"
  fill_in "Nif comprador", with: "00000000T"
  fill_in "justificante_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Segundo apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "Matricula", with: "AAA"
  fill_in "Bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar justificante"
end

When(/^I submit not all the needed information for a new Justificante$/) do
  visit new_online_justificante_path
  click_button "Solicitar justificante"
end

When(/^another Justificante from my Cliente is added$/) do
  internal_justificante = FactoryGirl.create( :justificante, modelo: "Nuevo justificante interno",
    cliente: cliente )
end

When(/^I access the edit page for a given Justificante$/) do
  # Usuario.count.should eql 1
  # Justificante.count.should eql 2
  # Justificante.where(cliente_id: Usuario.first.organizacion.cliente_ids)
  visit edit_online_justificante_path(Justificante.first)
end

Then(/^a new Justificante should (not )?be created$/) do |negation|
  if negation
    Justificante.all.count.should eql( 0 )
  else
    Justificante.all.count.should eql( 1 )
  end
end

Then(/^I should see a list of the Justificantes$/) do
  page.should have_title( I18n.t( "Justificantes" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  justificantes = usuario.justificantes do |justificante|
    page.should have_selector( 'td', text: justificante.matricula )
  end
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
end

Then(/^I should see a list of all the Justificantes$/) do
  page.should have_title( I18n.t( "Justificantes" ) )
  Justificante.count.should eql 1
  expect( page ).to have_selector( 'tr.justificante', count: 1 )
end

Then(/^the first Justificante should be the most urgent one$/) do
  expect( first( 'tr.justificante' ) ).to have_selector( 'td', text: "Otro justificante" )
end

Then(/^I should see just the list of the Justificantes from my Cliente$/) do
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Justificante externo" )
end

Then(/^I should see the list of all the Justificantes from my Organizacion$/) do
  rows = Justificante.where(cliente_id: Organizacion.first.cliente_ids).count
  expect( page ).to have_selector( 'tr.justificante', count: rows )
end

Then(/^I should see the list of the Justificantes updated and sorted without reloading the page$/) do
  using_wait_time 11 do
    expect( page ).to have_selector( 'tr.justificante', count: 3 )
    expect( first( '#justificantes tr.justificante' ) ).to have_selector( 'td', text: "Nuevo justificante interno" )
  end
end

Then(/^I should (not )?see a link to edit the Justificantes$/) do |negation|
  if negation
    rows = 0
  else
    rows = Justificante.count
  end
  expect( page ).to have_selector( 'i.toedit', count: rows )
end

Then(/^I should be able to edit the Justificante$/) do
  page.should have_title( I18n.t( "Editar Justificante Profesional" ) )
  page.should have_selector( "form.justificantes" )
end