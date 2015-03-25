Feature: Mandatos creation
  As a registered User
  In order to have all my Mandatos in one place
  I should be able to add a new Mandato

After do
  Warden.test_reset! 
end

  Scenario: try to create a new Mandato missing data
    Given I am a registered User
    When I submit not all the needed information for a new Mandato
    Then a new Mandato should not be created

  Scenario: create a new Mandato
    Given I am a registered User
    When I submit all the information for a new Mandato
    Then a new Mandato should be created

  Scenario: create a new Mandato for a person
    Given I am a registered User
    When I submit all the information for a new Mandato for a person
    Then a new Mandato should be created

@javascript 
  Scenario: create a new Mandato for a used vehicle
    Given I am a registered User
    When I submit all the information for a new Mandato for a used vehicle
    Then a new Mandato should be created

@javascript 
  Scenario: create a new Mandato for a new vehicle
    Given I am a registered User
    When I submit all the information for a new Mandato for a new vehicle
    Then a new Mandato should be created

@clock
  Scenario: new Mandato form shows the current server Time
    Given I am a registered User
    When I am going to create a new Mandato
    Then I should see the current server Time as H:m

@javascript 
  Scenario: try to create a new Mandato for a person
    Given I am a registered User
    When I submit all the information for a new Mandato for a person but without first name
    Then a new Mandato should not be created
      And I should be reminded to fulfill the first name field to create the Mandato

@javascript 
  Scenario: try to create a new Mandato for a used vehicle without matricula
    Given I am a registered User
    When I submit all the information for a new Mandato for a used vehicle but without matricula
    Then a new Mandato should not be created
      And I should be reminded to fulfill the matricula field to create the Mandato

@javascript 
  Scenario: try to create a new Mandato for a new vehicle without bastidor
    Given I am a registered User
    When I submit all the information for a new Mandato for a new vehicle but without bastidor
    Then a new Mandato should not be created
      And I should be reminded to fulfill the bastidor field to create the Mandato

@javascript 
  Scenario: create a new Mandato for a company
    Given I am a registered User
    When I submit all the information for a new Mandato for a company
    Then a new Mandato should be created

@javascript @prueba
  Scenario: try to create a new Mandato for a company without name representante
    Given I am a registered User
    When I submit all the information for a new Mandato for a company without name representante
    Then a new Mandato should not be created
      And I should be reminded to fulfill the representante data fields to create the Mandato

@javascript @prueba
  Scenario: try to create a new Mandato for a company without first name representante
    Given I am a registered User
    When I submit all the information for a new Mandato for a company without first name representante
    Then a new Mandato should not be created
      And I should be reminded to fulfill the representante data fields to create the Mandato

@javascript @prueba
  Scenario: try to create a new Mandato for a company without nif representante
    Given I am a registered User
    When I submit all the information for a new Mandato for a company without nif representante
    Then a new Mandato should not be created
      And I should be reminded to fulfill the representante data fields to create the Mandato

@email @guardia
  Scenario Outline: create a new Mandato on Saturday or Sunday implies an email
    Given I am a registered User
    When a new Mandato is created during a <weekday>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo mandato" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo mandato" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created mandato
  Examples:
    |weekday|
    |Saturday|
    |Sunday|

@email @guardia
  Scenario Outline: create a new Mandato on Friday after 17h implies an email
    Given I am a registered User
    When a new Mandato is created a Friday at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo mandato" in the email subject
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Se ha recibido una solicitud de nuevo mandato" in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created mandato
  Examples:
    |moment|
    |17.01|
    |17.59|
    |19.35|

@email @guardia
  Scenario Outline: create a new Mandato any other day after 19h implies an email
    Given I am a registered User
    When a new Mandato is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo mandato" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo mandato" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created mandato
  Examples:
    |day|moment|
    |Monday|19.01|
    |Tuesday|23.44|
    |Wednesday|20.02|
    |Thursday|19.15|

@email @guardia
  Scenario Outline: create a new Mandato any other day before 19h does not imply an email
    Given I am a registered User
    When a new Mandato is created a <day> at <moment>
    Then the employees on guard would not receive an email
  Examples:
    |day|moment|
    |Monday|18.01|
    |Tuesday|13.44|
    |Wednesday|10.02|
    |Thursday|15.15|

@email @guardia
  Scenario Outline: create a new Mandato implies an email always if out-of-office is enabled
    Given I am a registered User
      And the out-of-office option is enabled in Guardias
    When a new Mandato is created a <day> at <moment>
    Then the employees on guard would receive an email
    When I open the email
    Then I should see "Recibida solicitud de nuevo mandato" in the email subject
    Then I should see "Se ha recibido una solicitud de nuevo mandato" in the email body
    Then I should see "Sinapse Consulting S.L." in the email body
    Then I should see "Puede acceder a la solicitud" in the email body
    When I follow "este enlace" in the email
    Then I should see the newly created mandato
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