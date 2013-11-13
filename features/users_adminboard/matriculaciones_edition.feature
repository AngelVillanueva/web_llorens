@current
Feature: Matriculaciones edition
  As an admin or employee User
  In order to complete my Matriculaciones
  I should be able to edit an existing Matriculacion by adding a PDF

After do
  Warden.test_reset! 
end
  
  Scenario: admin users can see the link to edit Matriculaciones
    Given I am an admin user
      And there are some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should see a link to edit the Matriculaciones
  
  Scenario: employee users can see the link to edit Matriculacioness
    Given I am an employee user
      And there are some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should see a link to edit the Matriculaciones
  
  Scenario: registered users cannot see the link to edit Matriculaciones
    Given I am a registered User with some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should not see a link to edit the Matriculaciones
  @wip
  Scenario: registered users cannot access the edit page for Informes
    Given I am a registered User with some Informes
    When I access the edit page for a given Informe
    Then I should be redirected to the homepage
  @wip
  Scenario: employee users can access the edit page for Informes
    Given I am an employee user
      And there are also Informes from other Clientes
    When I access the edit page for a given Informe
    Then I should be able to edit the Informe
  @wip
  Scenario: admin users can access the edit page for Informes
    Given I am an admin user
      And there are also Informes from other Clientes
    When I access the edit page for a given Informe
    Then I should be able to edit the Informe