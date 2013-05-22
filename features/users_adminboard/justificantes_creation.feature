Feature: Justificantes creation
  As a registered User
  In order to have all my Justificantes in one place
  I should be able to add a new Justificante

  Scenario: try to create a new Justificante missing data
    Given I am a registered User
    When I submit not all the needed information for a new Justificante
    Then a new Justificante should not be created

  Scenario: create a new Justificante
    Given I am a registered User
    When I submit all the information for a new Justificante
    Then a new Justificante should be created