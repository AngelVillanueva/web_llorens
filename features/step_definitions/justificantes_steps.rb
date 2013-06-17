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

Then(/^a new Justificante should (not )?be created$/) do |negation|
  if negation
    Justificante.all.count.should eql( 0 )
  else
    Justificante.all.count.should eql( 1 )
  end
end