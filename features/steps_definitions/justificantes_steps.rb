When(/^I submit all the information for a new Justificante$/) do
  visit new_justificante_path
  click_button "Generar Justificante"
end

Then(/^a new Justificante should be created$/) do
  pending # express the regexp above with the code you wish you had
end