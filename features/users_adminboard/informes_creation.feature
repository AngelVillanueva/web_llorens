Feature: Informes creation
  As a registered User
  In order to have all my Informes in one place
  I should be able to add a new Informe

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
@email
  Scenario Outline: create a new Informe on Saturday or Sunday implies an email
    Given I am a registered User
    When a new Informe is created during a <weekday>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo informe" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo informe" in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created informe
  Examples:
    |weekday|
    |Saturday|
    |Sunday|

@email
  Scenario Outline: create a new Informe any other day does not implies an email
    Given I am a registered User
    When a new Informe is created during a <weekday>
    Then "email1@llorens.com" should receive no email
  Examples:
    |weekday|
    |Monday|
    |Friday|