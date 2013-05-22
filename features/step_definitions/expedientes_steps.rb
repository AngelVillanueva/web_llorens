When(/^I submit all the information for a new Expediente$/) do
  visit new_expediente_path
  fill_in "Identificador", with: "IM1"
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