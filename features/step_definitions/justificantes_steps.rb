Given(/^one of the justificantes has an attached PDF$/) do
  justificante = Justificante.find_by_matricula( "Test justificante" )
  justificante.pdf_content_type = "application/pdf"
end

Given(/^there are also Justificantes from other Organizaciones$/) do
  acompany = FactoryGirl.create( :organizacion, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_justificantes = FactoryGirl.create( :justificante, matricula: "Justificante externo",
    organizacion: acompany )
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
  click_button "Solicitar justificante"
end

When(/^I submit not all the needed information for a new Justificante$/) do
  visit new_online_justificante_path
  click_button "Solicitar justificante"
end

When(/^another Justificante from my Organizacion is added$/) do
  internal_justificante = FactoryGirl.create( :justificante, matricula: "Nuevo justificante interno",
    organizacion: organizacion )
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
  justificantes = usuario.organizacion.justificantes do |justificante|
    page.should have_selector( 'td', text: justificante.matricula )
  end
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
end

Then(/^the first Justificante should be the most urgent one$/) do
  expect( first( 'tr.justificante' ) ).to have_selector( 'td', text: "Otro justificante" )
end

Then(/^I should see just the list of the Justificantes from my Organizacion$/) do
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Justificante externo" )
end

Then(/^I should see the list of the Justificantes updated and sorted without reloading the page$/) do
  using_wait_time 11 do
    expect( page ).to have_selector( 'tr.justificante', count: 3 )
    expect( first( '#informes tr.justificante' ) ).to have_selector( 'td', text: "Nuevo justificante interno" )
  end
end