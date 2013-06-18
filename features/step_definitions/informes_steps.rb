Given(/^one of the informes has an attached PDF$/) do
  informe = Informe.find_by_matricula( "Test informe" )
  informe.pdf_content_type = "application/pdf"
end

Given(/^there are also Informes from other Organizaciones$/) do
  acompany = FactoryGirl.create( :organizacion, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_informe = FactoryGirl.create( :informe, matricula: "Informe externo",
    organizacion: acompany )
end

When(/^another Informe from my Organizacion is added$/) do
  internal_informe = FactoryGirl.create( :informe, matricula: "Nuevo informe interno",
    organizacion: organizacion )
end

Then(/^I should see a list of the Informes$/) do
  page.should have_title( I18n.t( "Informes de trafico" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  informes = usuario.organizacion.informes do |informe|
    page.should have_selector( 'td', text: informe.matricula )
  end
  expect( page ).to have_selector( 'tr.informe', count: 2 )
end

Then(/^the first Informe should be the most urgent one$/) do
  expect( first( 'tr.informe' ) ).to have_selector( 'td', text: "Otro informe" )
end

Then(/^I should see just the list of the Informes from my Organizacion$/) do
  expect( page ).to have_selector( 'tr.informe', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Informe externo" )
end

Then(/^I should see the list of the Informes updated and sorted without reloading the page$/) do
  using_wait_time 11 do
    expect( page ).to have_selector( 'tr.informe', count: 3 )
    expect( first( '#informes tr.informe' ) ).to have_selector( 'td', text: "Nuevo informe interno" )
  end
end