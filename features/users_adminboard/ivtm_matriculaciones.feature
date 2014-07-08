@ivtm
Feature: IVTM for Matriculaciones
As a user of the application
In order to know the status of a Matriculacion
I need a 'IVTM' field

After do
  Warden.test_reset! 
end

  Scenario: registered users can see IVTM in the Matriculacion listing
    Given I am a registered User with some Expedientes
    When I access the Matriculaciones index page
    Then I should see the IVTM field

  Scenario: Transferencias have no IVTM
    Given I am a registered User with some Expedientes
    When I access the Transferencias index page
    Then I should not see the IVTM field

  Scenario: a 0 IVTM field should show a "0" as a value
    Given I am a registered User with some Expedientes
      And one of them has "0" IVTM
    When I access the Matriculaciones index page
    Then I should the right value for the "0" IVTM cell

  Scenario: an empty IVTM field should show a "Pendiente" as a value
    Given I am a registered User with some Expedientes
      And one of them has "no" IVTM
    When I access the Matriculaciones index page
    Then I should the right value for the "empty" IVTM cell

  Scenario: a regular IVTM field should show its value with two decimal digits
    Given I am a registered User with some Expedientes
      And one of them has "38.987" IVTM
    When I access the Matriculaciones index page
    Then I should the right value for the "regular" IVTM cell
