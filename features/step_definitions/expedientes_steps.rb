Given(/^there are more Expedientes from other Organizaciones$/) do
  other_organizacion = Organizacion.create( nombre: "Other O", identificador: "OOO", cif: "00000000T" )
  other_expediente = FactoryGirl.create( :matriculacion, matricula: "Other matricula", organizacion: other_organizacion )
end

Given(/^one new Transferencia was created yesterday$/) do
  y_transferencia = FactoryGirl.create(:transferencia, matricula: "Test yesterday", organizacion: organizacion, fecha_alta: 1.day.ago )
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
  fill_in 'expedientes_range_from_5', with: 1.day.ago.strftime("%d/%m/%Y")
  fill_in 'expedientes_range_to_5', with: 1.day.ago.strftime("%d/%m/%Y")
  page.execute_script %Q{ $('#expedientes_range_from_5').trigger("focus") } # activate datetime picker
end

Then(/^I should see a list of the Expedientes$/) do
  page.should have_title( "Listado de Expedientes" )
  expedientes = Expediente.all.each do |expediente|
    page.should have_selector( 'td', text: expediente.matricula )
  end
end

Then(/^I should see just the Transferencia created yesterday$/) do
  page.should have_selector( 'td', text: "Test yesterday" )
  page.should have_selector( 'tr.expediente', count: 1 )
end

Then(/^I should see a list of the Matriculaciones$/) do
  page.should have_title( "Listado de Matriculaciones" )
  matriculaciones = Matriculacion.all.each do |matriculacion|
    page.should have_selector( 'td', text: matriculacion.matricula )
  end
end

Then(/^I should see a list of the Transferencias$/) do
  page.should have_title( "Listado de Transferencias" )
  transferencias = Transferencia.all.each do |transferencia|
    page.should have_selector( 'td', text: transferencia.matricula )
  end
end

Then(/^a new Expediente should be created$/) do
  Expediente.count.should eql( 1 )
end

Then(/^I should just see the list of my Expedientes$/) do
  page.should have_content( "Test matricula" )
  page.should_not have_content( "Other matricula" )
end

Then(/^I should (not )?see a detail of that Expediente$/) do |negation|
  if negation
    page.should have_css( '.alert-alert' )
  else
    page.should have_css( 'h1', "Expediente para #{Expediente.first.matricula}" )
    page.should have_selector( 'iframe.pdf' )
  end
end