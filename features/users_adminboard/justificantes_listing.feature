@wip
Feature: Justificantes listing
  As a registered User
  In order to find out the Justificantes status
  I should be able to list the Justificantes

After do
  Warden.test_reset! 
end

Scenario: Expedientes index
  Given I am a registered User with some Justificantes
  When I access the Justificanes index page
  Then I should see a list of the Justificantes