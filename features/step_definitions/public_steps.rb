Then(/^I should see the new sales contact information$/) do
  expect( page ).to have_css( ".info", text: I18n.t( "Maurici Cardos" ) )
  expect( page ).to have_css( ".info a", text: "mcardos@gestoriallorens.com" )
end