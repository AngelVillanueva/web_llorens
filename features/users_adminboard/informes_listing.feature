Feature: Informes listing
  In order to check the status of all the Informes
  as an Usuario
  I should be able to see a list of all my Informes

  Scenario: an Usuario can see all her Informes
    Given I am a registered User with some Informes
    When I access the Informes index page
    Then I should see a list of the Informes

  Scenario: "matricula" in Informes is always uppercase
    Given I am a registered User with some Informes
    When I access the Informes index page
    Then I should see a list of the Informes with matricula in uppercase

  Scenario: the Informes are sorted by not having a PDF yet and then by created_at field
    Given I am a registered User with some Informes
      And one of the informes has an attached PDF
    When I access the Informes index page
    Then I should see a list of the Informes
      And the first Informe should be the most urgent one

  Scenario: an Usuario can not see Informes from other Cliente
    Given I am a registered User with some Informes
      And there are also Informes from other Clientes but from my Organizacion
    When I access the Informes index page
    Then I should see just the list of the Informes from my Cliente

  Scenario: an Usuario cannot see all the Informes from her Organizacion
    Given I am a registered User with no Informes
      And there are also Informes from other Clientes of my Organizacion
    When I access the Informes index page
    Then I should not see the list of all the Informes from my Organizacion

  Scenario: an admin user can see all Informes
    Given I am an admin user
      And there are also Informes from other Clientes
    When I access the Informes index page
    Then I should see a list of all the Informes
  
  Scenario: an employee user can see all Informes
      Given I am an employee user
        And there are also Informes from other Clientes
      When I access the Informes index page
      Then I should see a list of all the Informes

  @javascript 
  Scenario: the list of Informes is auto updated via ajax
    Given I am a registered User with some Informes
    When I access the Informes index page
      And another Informe from my Cliente is added
    Then I should see the list of the Informes updated and sorted without reloading the page

  @javascript
  Scenario: Users can filter by date
    Given I am a registered User with some Informes
      And one new Informe was created yesterday
    When I access the Informes index page
      And I filter the Informes by the date of yesterday
    Then I should see just the Informe created yesterday

