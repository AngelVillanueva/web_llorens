Feature: Informes creation
  As a registered User
  In order to have all my Informes in one place
  I should be able to add a new Justificante

After do
  Warden.test_reset! 
end

  Scenario: try to create a new Informes missing data
    Given I am a registered User
    When I submit not all the needed information for a new Informe
    Then a new Informe should not be created

  Scenario: create a new Informe
    Given I am a registered User
    When I submit all the information for a new Informe
    Then a new Informe should be created