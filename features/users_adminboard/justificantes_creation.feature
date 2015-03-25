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

  Scenario: create a new Justificante for a person
    Given I am a registered User
    When I submit all the information for a new Justificante for a person
    Then a new Justificante should be created
@clock
  Scenario: new Justificante form shows the current server Time
    Given I am a registered User
    When I am going to create a new Justificante
    Then I should see the current server Time as H:m

@javascript
  Scenario: try to create a new Justificante for a person
    Given I am a registered User
    When I submit all the information for a new Justificante for a person but without first name
    Then a new Justificante should not be created
      And I should be reminded to fulfill the first name field to create the Justificante

@javascript
  Scenario: create a new Justificante for a person
    Given I am a registered User
    When I submit all the information for a new Justificante for a company
    Then a new Justificante should be created

@email @guardia
  Scenario Outline: create a new Justificante on Saturday or Sunday implies an email
    Given I am a registered User
    When a new Justificante is created during a <weekday>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo justificante" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo justificante" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created justificante
  Examples:
    |weekday|
    |Saturday|
    |Sunday|

@email @guardia
  Scenario Outline: create a new Justificante on Friday after 17h implies an email
    Given I am a registered User
    When a new Justificante is created a Friday at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo justificante" in the email subject
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Se ha recibido una solicitud de nuevo justificante" in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created justificante
  Examples:
    |moment|
    |17.01|
    |17.59|
    |19.35|

@email @guardia
  Scenario Outline: create a new Justificante any other day after 19h implies an email
    Given I am a registered User
    When a new Justificante is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo justificante" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo justificante" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created justificante
  Examples:
    |day|moment|
    |Monday|19.01|
    |Tuesday|23.44|
    |Wednesday|20.02|
    |Thursday|19.15|

@email @guardia
  Scenario Outline: create a new Justificante any other day before 19h does not imply an email
    Given I am a registered User
    When a new Justificante is created a <day> at <moment>
    Then the employees on guard would not receive an email
  Examples:
    |day|moment|
    |Monday|18.01|
    |Tuesday|13.44|
    |Wednesday|10.02|
    |Thursday|15.15|

@email @guardia
  Scenario Outline: create a new Justificante implies an email always if out-of-office is enabled
    Given I am a registered User
      And the out-of-office option is enabled in Guardias
    When a new Justificante is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo justificante" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo justificante" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created justificante
  Examples:
    |day|moment|
    |Monday|19.01|
    |Tuesday|23.44|
    |Wednesday|20.02|
    |Thursday|19.15|
    |Monday|15.01|
    |Tuesday|13.44|
    |Wednesday|10.02|
    |Thursday|09.15|
    |Friday|14.58|
    |Friday|18.01|
    |Saturday|10.00|
    |Sunday|23.58|