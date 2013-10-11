@current
Feature: password expiration
  As the webapp owner
  In order to meet the legal requirements
  I should force to change the password each year

  Scenario: password expiration after 1 year
  Given I am a registered User who did not change my password during the last year
  When I visit the application home page
  Then I should be redirected to the renewal password page