Feature: Justificantes creation
  As a registered User
  In order to have all my Justificantes in one place
  I should be able to add a new Justificante

After do
  Warden.test_reset! 
end

  Scenario: try to create a new Justificante missing data
    Given I am a registered User
    When I submit not all the needed information for a new Justificante
    Then a new Justificante should not be created

  Scenario: create a new Justificante
    Given I am a registered User
    When I submit all the information for a new Justificante
    Then a new Justificante should be created
@now
  Scenario: create a new Justificante for a person
    Given I am a registered User
    When I submit all the information for a new Justificante for a person
    Then a new Justificante should be created

@now @javascript
  Scenario: create a new Justificante for a person
    Given I am a registered User
    When I submit all the information for a new Justificante for a company
    Then a new Justificante should be created

@email
  Scenario Outline: create a new Justificante on Saturday or Sunday implies an email
    Given I am a registered User
    When a new Justificante is created during a <weekday>
    Then "email1@llorens.com" should receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo justificante" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo justificante" in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created justificante
  Examples:
    |weekday|
    |Saturday|
    |Sunday|

@email
  Scenario Outline: create a new Justificante any other day does not implies an email
    Given I am a registered User
    When a new Justificante is created during a <weekday>
    Then "email1@llorens.com" should receive no email
  Examples:
    |weekday|
    |Monday|
    |Friday|