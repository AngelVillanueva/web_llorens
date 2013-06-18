Feature: Informes listing
  In order to check the status of all the Informes
  as an Usuario
  I should be able to see a list of all my Informes

  Scenario: an Usuario can see all her Informes
    Given I am a registered User with some Informes
    When I access the Informes index page
    Then I should see a list of the Informes

  Scenario: the Informes are sorted by not having a PDF yet and then by created_at field
    Given I am a registered User with some Informes
      And one of the informes has an attached PDF
    When I access the Informes index page
    Then I should see a list of the Informes
      And the first Informe should be the most urgent one

  Scenario: an Usuario can not see Informes from other Organizacion
    Given I am a registered User with some Informes
      And there are also Informes from other Organizaciones
    When I access the Informes index page
    Then I should see just the list of the Informes from my Organizacion

  @javascript
  Scenario: the list of Informes is auto updated via ajax
    Given I am a registered User with some Informes
    When I access the Informes index page
      And another Informe from my Organizacion is added
    Then I should see the list of the Informes updated and sorted without reloading the page

