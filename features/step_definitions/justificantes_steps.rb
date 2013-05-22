When(/^I submit all the information for a new Justificante$/) do
  visit new_justificante_path
  fill_in "Nif comprador", with: "00000000T"
  click_button "Generar Justificante"
end

When(/^I submit not all the needed information for a new Justificante$/) do
  visit new_justificante_path
  click_button "Generar Justificante"
end

Then(/^a new Justificante should (not )?be created$/) do |negation|
  if negation
    Justificante.all.count.should == 0
  else
    Justificante.all.count.should == 1
  end
end