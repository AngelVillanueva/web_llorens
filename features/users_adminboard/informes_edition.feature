Feature: Informes edition
  As an admin or employee User
  In order to complete my Informes
  I should be able to edit an existing Informe

After do
  Warden.test_reset! 
end
  
  Scenario: admin users can see the link to edit Informes
    Given I am an admin user
      And there are also Informes from other Clientes
    When I access the Informes index page
    Then I should see a link to edit the Informes
  
  Scenario: employee users can see the link to edit Informes
    Given I am an employee user
      And there are also Informes from other Clientes
    When I access the Informes index page
    Then I should see a link to edit the Informes

  Scenario: registered users cannot see the link to edit Informes
    Given I am a registered User with some Informes
    When I access the Informes index page
    Then I should not see a link to edit the Informes

  @current
  Scenario: registered users cannot access the edit page for Informes
    Given I am a registered User with some Informes
    When I access the edit page for a given Informe
    Then I should be redirected to the homepage