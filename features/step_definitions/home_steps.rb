Then(/^I should (not )?be able to access the application$/) do |negation|
  if negation
    page.should_not have_title( I18n.t("Area usuarios") )
    page.should have_css( '.alert-alert', I18n.t("devise.failure.unauthenticated" ) )
  else
    page.should have_title( I18n.t("Area usuarios") )
  end
end

Then (/^I should see the following links$/) do |table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      page.should have_content( value )
    end
  end
end

Then(/^I should be redirected to the renewal password page$/) do
  page.should have_css( 'h2', text: I18n.t("Renew your password") )
end