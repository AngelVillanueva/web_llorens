When(/^I visit the contact page$/) do
  visit contact_path
end

When(/^I visit a different page$/) do
  visit download_path
end

When(/^I submit the form without some of the fields$/) do
  fill_in "inputName", with: "Angel"
  click_button "Enviar"
end

When(/^I submit the form with all of the fields as blanks$/) do
  click_button "Enviar"
end

When(/^I try to submit the contact form without checking the TOS box$/) do
  visit contact_path
  fill_in "inputName", with: "Angel"
  fill_in "inputEmail", with: "my@email.com"
  fill_in "inputPhone", with: "900000000"
  fill_in "inputCity", with: "Albacete"
  fill_in "inputComment", with: "Necesito saberlo, por favor."
  click_button "Enviar"
end

When(/^I submit the form with all the fields$/) do
  visit contact_path
  fill_in "inputName", with: "Angel"
  fill_in "inputEmail", with: "requester@example.com"
  fill_in "inputPhone", with: "900000000"
  fill_in "inputCity", with: "Albacete"
  fill_in "inputComment", with: "Necesito saberlo, por favor."
  check "inputTOS"
  click_button "Enviar"
end

Then(/^I should see a Contact form$/) do
  page.should have_selector("form#contact_form")
end

Then(/^I should( not)? see an error message$/) do |negation|
  if negation
    page.should_not have_selector(".flash.alert-error")
  else
    page.should have_selector(".flash.alert-error")
  end
end