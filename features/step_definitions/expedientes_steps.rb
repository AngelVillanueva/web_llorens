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
  page.should have_content "IM-test"
  page.should_not have_content "Other-test"
end