Feature: Justificantes creation
  As a registered User
  In order to have all my Justificantes in one place
  I should be able to add a new Justificante

  Scenario: create a new Justificantes
    Given I am a registered User
    When I submit all the information for a new Justificante
    Then a new Justificante should be created