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

Given(/^one new Informe was created yesterday$/) do
  y_informe = FactoryGirl.create(:informe, matricula: "Test yesterday", organizacion: organizacion, created_at: 1.day.ago )
end

When(/^another Informe from my Organizacion is added$/) do
  internal_informe = FactoryGirl.create( :informe, matricula: "Nuevo informe interno",
    organizacion: organizacion )
end

When(/^I filter the Informes by the date of yesterday$/) do
  fill_in 'informes_range_from_3', with: 1.day.ago.strftime("%d/%m/%Y")
  fill_in 'informes_range_to_3', with: 1.day.ago.strftime("%d/%m/%Y")
  page.execute_script %Q{ $('#informes_range_from_3').trigger("focus") } # activate datetime picker
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

Then(/^I should see just the Informe created yesterday$/) do
  expect( page ).to have_selector( 'tr.informe', count: 1 )
end