@current
Feature: Matriculaciones PDFs for matricula
  As an admin or employee User
  In order to manage my Matriculaciones
  I should be able to complete an existing Matriculacion by adding a PDF

After do
  Warden.test_reset! 
end
  
  Scenario: admin users can see the link to add a PDF to Matriculaciones
    Given I am an admin user
      And there are some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should see a link to "add" the Matriculaciones PDF

  Scenario: employee users can see the link to add a PDF to Matriculaciones
    Given I am an employee user
      And there are some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should see a link to "add" the Matriculaciones PDF

  Scenario: registered users cannot see the link to add a PDF to Matriculaciones
    Given I am a registered User with some Expedientes without matricula
    When I access the Matriculaciones index page
    Then I should not see a link to "add" the Matriculaciones PDF

  Scenario: admin users can see the link to edit Matriculaciones
    Given I am an admin user
      And there are more Expedientes from other Clientes
    When I access the Matriculaciones index page
    Then I should see a link to "edit" the Matriculaciones PDF

  Scenario: employee users can see the link to edit Matriculacioness
    Given I am an employee user with some Expedientes
    When I access the Matriculaciones index page
    Then I should see a link to "edit" the Matriculaciones PDF
  @wip
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