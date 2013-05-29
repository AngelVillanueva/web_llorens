Then(/^I should (not )?be able to access the application$/) do |negation|
  if negation
    page.should_not have_title( "Bienvenido" )
    page.should have_css( '.alert-alert', I18n.t("devise.failure.unauthenticated" ) )
  else
    page.should have_title( "Bienvenido" )
  end
end

Then (/^I should see the following links$/) do |table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      page.should have_content( value )
    end
  end
end