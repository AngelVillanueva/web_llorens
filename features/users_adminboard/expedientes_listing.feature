Feature: Expedientes listing
  As a registered User
  In order to find out the Expedientes status
  I should be able to list the Expedientes

After do
  Warden.test_reset! 
end

Scenario: Expedientes index
  Given I am a registered User with some Expedientes
  When I access the Expedientes index page
  Then I should see a list of the Expedientes