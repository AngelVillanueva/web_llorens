Feature: Expedientes types
  As Gestoria Llorens
  I should be able to access different types of Expedientes
  in order to manage them separately

  Background:
    Given I am a registered User with some Expedientes

    Scenario: Access Matriculaciones
      When I access the Matriculaciones index page
      Then I should see a list of the Matriculaciones

    Scenario: Access Transferencias
      When I access the Transferencias index page
      Then I should see a list of the Transferencias