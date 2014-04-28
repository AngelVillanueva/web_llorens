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
@clock
  Scenario: new Informe form shows the current server Time
    Given I am a registered User
    When I am going to create a new Informe
    Then I should see the current server Time as H:m
@email @guardia
  Scenario Outline: create a new Informe on Saturday or Sunday implies an email
    Given I am a registered User
    When a new Informe is created during a <weekday>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo informe" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo informe" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created informe
  Examples:
    |weekday|
    |Saturday|
    |Sunday|

@email @guardia
  Scenario Outline: create a new Informe on Friday after 17h implies an email
    Given I am a registered User
    When a new Informe is created a Friday at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo informe" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo informe" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created informe
  Examples:
    |moment|
    |17.01|
    |17.44|
    |18.02|

@email @guardia
  Scenario Outline: create a new Informe on Friday before 17h does not imply an email
    Given I am a registered User
    When a new Informe is created a Friday at <moment>
    Then the employees on guard would not receive an email
  Examples:
    |moment|
    |16.59|
    |15.30|
    |05.01|

@email @guardia
  Scenario Outline: create a new Informe any other day after 19h implies an email
    Given I am a registered User
    When a new Informe is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo informe" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo informe" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created informe
  Examples:
    |day|moment|
    |Monday|19.01|
    |Tuesday|23.44|
    |Wednesday|20.02|
    |Thursday|19.15|

@email @guardia
  Scenario Outline: create a new Informe any other day before 19h does not imply an email
    Given I am a registered User
    When a new Informe is created a <day> at <moment>
    Then the employees on guard would not receive an email
  Examples:
    |day|moment|
    |Monday|18.01|
    |Tuesday|13.44|
    |Wednesday|10.02|
    |Thursday|15.15|

@email @guardia
  Scenario Outline: create a new Informe implies an email always if out-of-office is enabled
    Given I am a registered User
      And the out-of-office option is enabled in Guardias
    When a new Informe is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo informe" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo informe" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created informe
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