Feature: Incidencias for Transferencias
As a user of the application
In order to know the status of a Transferencia
I need a 'Incidencias' field

After do
  Warden.test_reset! 
end

  Scenario: registered users can see Incidencias in the Transferencias listing
    Given I am a registered User with some Expedientes
      And one of them is a "Transferencia" and has an Incidencia
    When I access the Transferencias index page
    Then I should see an Incidencia warning

  Scenario: Matriculaciones have no Incidencias
    Given I am a registered User with some Expedientes
      And one of them is a "Matriculacion" and has an Incidencia
    When I access the Matriculaciones index page
    Then I should not see an Incidencia warning

  Scenario: empty Incidencia field should not show an Incidencia warning
    Given I am a registered User with some Expedientes
      And one of them is a "Transferencia" and has an Incidencia
      But the Incidencia has no text
    When I access the Transferencias index page
    Then I should not see an Incidencia warning

  Scenario: a nil Incidencia field should not show an Incidencia warning
    Given I am a registered User with some Expedientes
      And one of them is a "Transferencia" and has an Incidencia
      But the Incidencia is nil
    When I access the Transferencias index page
    Then I should not see an Incidencia warning

  Scenario: a Transferencia with an Incidencia should appear at the top of the list
    Given I am a registered User with some Expedientes
      And one of them is a "Transferencia" and has an Incidencia
      And the one with Incidencia is older
    When I access the Transferencias index page
    Then the Transferencia with Incidencia should appear the first one
@javascript @popover
  Scenario: the Incidencia icon should show the detail on click
    Given there is an Incidencia in the page
    When I hover over the Incidencia icon
    Then I should see the Incidencia detail
@javascript @popover
  Scenario: a solved Incidencia should show the solving date as well
    Given there is an Incidencia in the page
      And that Incidencia has been solved
    When I hover over the Incidencia icon
    Then I should see the Incidencia detail
      And I should see the solving date
@javascript @popover
  Scenario: a solved but reopened Incidencia should not show the solving date
    Given there is an Incidencia in the page
      And that Incidencia has been solved
    When I hover over the Incidencia icon
    Then I should see the Incidencia detail
      And I should see the solving date
    When another Incidencia is added to that Expediente
      And the previous Fecha Resolucion is cleared
      And I access the Transferencias index page
      And I hover over the Incidencia icon
    Then I should see the whole Incidencia detail
      But I should not see the solving date

  Scenario: an unsolved Incidencia should appear in the list above than solved ones
    Given there is an Incidencia in the page
      And there was a previous Expediente with unsolved Incidencia in the page
    Then that previous Expediente should appear at the top of the list
    And there is a new, more recent Expediente with an Incidencia in the page
    Then that more recent Expediente should appear at the top of the list
    When that more recent Incidencia has been solved
      And I access the Transferencias index page
    Then the unsolved Incidencia should appear at the top of the list
