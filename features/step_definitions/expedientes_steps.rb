Given(/^there are more Expedientes from other Organizaciones$/) do
  other_organizacion = Organizacion.create(nombre: "Other O", identificador: "OOO", cif: "00000000T")
  other_expediente = Expediente.create(identificador: "Other-test", matricula: "Other matricula", organizacion: other_organizacion)
end

When(/^I submit all the information for a new Expediente$/) do
  visit new_expediente_path
  fill_in "Identificador", with: "IM1"
  fill_in "Organization", with: Usuario.last.organizacion_id
  click_button "Crear Expediente"
end

When(/^I access the page for the first Expediente$/) do
  visit expediente_path Expediente.first
end
When(/^I access the page for the second Expediente$/) do
  visit expediente_path Expediente.find_by_matricula("Other matricula")
end

Then(/^I should see a list of the Expedientes$/) do
  page.should have_title("Listado de Expedientes")
  expedientes = Expediente.all.each do |expediente|
    page.should have_selector("td", text: expediente.matricula)
  end
end

Then(/^a new Expediente should be created$/) do
  Expediente.count.should == 1
end

Then(/^I should just see the list of my Expedientes$/) do
  page.should have_content "Test matricula"
  page.should_not have_content "Other matricula"
end

Then(/^I should (not )?see a detail of that Expediente$/) do |negation|
  if negation
    page.should have_css( '.alert-alert' )
  else
    page.should have_css( 'h1', "Expediente para #{Expediente.first.matricula}" )
    page.should have_selector( 'iframe.pdf' )
  end
end