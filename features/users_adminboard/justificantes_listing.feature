Feature: Justificantes listing
  As a registered User
  In order to find out the Justificantes status
  I should be able to list the Justificantes

  After do
    Warden.test_reset! 
  end

  Scenario: Justificantes index
    Given I am a registered User with some Justificantes
    When I access the Justificantes index page
    Then I should see a list of the Justificantes

  Scenario: the Justificantes are sorted by not having a PDF yet and then by created_at field
      Given I am a registered User with some Justificantes
        And one of the justificantes has an attached PDF
      When I access the Justificantes index page
      Then I should see a list of the Justificantes
        And the first Justificante should be the most urgent one

  Scenario: an Usuario can not see Justificantes from other Cliente
      Given I am a registered User with some Justificantes
        And there are also Justificantes from other Clientes
      When I access the Justificantes index page
      Then I should see just the list of the Justificantes from my Cliente

  Scenario: an Usuario can see all the Justificantes from her Organizacion
    Given I am a registered User with no Justificantes
      And there are also Justificantes from other Clientes of my Organizacion
    When I access the Justificantes index page
    Then I should see the list of all the Justificantes from my Organizacion
    
  Scenario: an admin user can see all Justificantes
      Given I am an admin user
        And there are also Justificantes from other Clientes
      When I access the Justificantes index page
      Then I should see a list of all the Justificantes
  
  Scenario: an employee user can see all Justificantes
      Given I am an employee user
        And there are also Justificantes from other Clientes
      When I access the Justificantes index page
      Then I should see a list of all the Justificantes

  @javascript
    Scenario: the list of Justificantes is auto updated via ajax
      Given I am a registered User with some Justificantes
      When I access the Justificantes index page
        And another Justificante from my Cliente is added
      Then I should see the list of the Justificantes updated and sorted without reloading the page