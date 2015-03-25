Feature: Mandatos listing
  As a registered User
  In order to find out the Mandatos status
  I should be able to list the Mandatos

  After do
    Warden.test_reset! 
  end

  Scenario: Mandatos index
    Given I am a registered User with some Mandatos
    When I access the Mandatos index page
    Then I should see a list of the Mandatos

  Scenario: Mandatos "matricula_bastidor" is always uppercase
    Given I am a registered User with some Mandatos
    When I access the Mandatos index page
    Then I should see a list of the Mandatos with matricula_bastidor in uppercase

  Scenario: an Usuario can not see Mandatos from other Cliente
      Given I am a registered User with some Mandatos
        And there are also Mandatos from other Clientes but from my Organizacion
      When I access the Mandatos index page
      Then I should see just the list of the Mandatos from my Cliente

  Scenario: an Usuario cannot see all the Mandatos from her Organizacion
    Given I am a registered User with no Mandatos
      And there are also Mandatos from other Clientes of my Organizacion
    When I access the Mandatos index page
    Then I should not see the list of all the Mandatos from my Organizacion
    
  Scenario: an admin user can see all Mandatos
      Given I am an admin user
        And there are also Mandatos from other Clientes
      When I access the Mandatos index page
      Then I should see a list of all the Mandatos
  
  Scenario: an employee user can see all Mandatos
      Given I am an employee user
        And there are also Mandatos from other Clientes
      When I access the Mandatos index page
      Then I should see a list of all the Mandatos

# test disabled due to long waiting time = 4 minutes
  @javascript @reload @wip
    Scenario: the list of Mandatos is auto updated via ajax
      Given I am a registered User with some Mandatos
      When I access the Mandatos index page
        And another Mandato from my Cliente is added
      Then I should see the list of the Mandatos updated and sorted without reloading the page