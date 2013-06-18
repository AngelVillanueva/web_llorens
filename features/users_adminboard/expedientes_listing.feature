Feature: Expedientes listing
  As a registered User
  In order to find out the Expedientes status
  I should be able to list the Expedientes

After do
  Warden.test_reset! 
end

Scenario: Matriculaciones index
  Given I am a registered User with some Expedientes
  When I access the Matriculaciones index page
  Then I should see a list of the Matriculaciones

Scenario: Transferencias index
  Given I am a registered User with some Expedientes
  When I access the Transferencias index page
  Then I should see a list of the Transferencias

Scenario: Users can see just the Expedientes from their Organizations
  Given I am a registered User with some Expedientes
    And there are more Expedientes from other Organizaciones
  When I access the Matriculaciones index page
  Then I should just see the list of my Expedientes
  
@javascript @now
Scenario: Users can filter by date
  Given I am a registered User with some Expedientes
    And one new Transferencia was created yesterday
  When I access the Transferencias index page
    And I filter the Transferencias by the date of yesterday
  Then I should see just the Transferencia created yesterday