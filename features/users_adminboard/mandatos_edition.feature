Feature: Mandatos edition
  As an admin or employee User
  In order to complete my Mandatos
  I should be able to edit an existing Mandato

After do
  Warden.test_reset! 
end
  
  Scenario: admin users can see the link to edit Mandatos
    Given I am an admin user
      And there are also Mandatos from other Clientes
    When I access the Mandatos index page
    Then I should see a link to edit the Mandatos
  
  Scenario: employee users can see the link to edit Mandatos
    Given I am an employee user
      And there are also Mandatos from other Clientes
    When I access the Mandatos index page
    Then I should see a link to edit the Mandatos

  Scenario: registered users cannot see the link to edit Mandatos
    Given I am a registered User with some Mandatos
    When I access the Mandatos index page
    Then I should not see a link to edit the Mandatos

  Scenario: registered users cannot access the edit page for Mandatos
    Given I am a registered User with some Mandatos
    When I access the edit page for a given Mandato
    Then I should be redirected to the homepage
 
  Scenario: employee users can access the edit page for Mandatos
    Given I am an employee user
      And there are also Mandatos from other Clientes
    When I access the edit page for a given Mandato
    Then I should be able to edit the Mandato

  Scenario: admin users can access the edit page for Mandatos
    Given I am an admin user
      And there are also Mandatos from other Clientes
    When I access the edit page for a given Mandato
    Then I should be able to edit the Mandato