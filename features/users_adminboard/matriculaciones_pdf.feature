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
      And there are more Expedientes from other Clientes with matricula PDF
    When I access the Matriculaciones index page
    Then I should see a link to "edit" the Matriculaciones PDF

  Scenario: employee users can see the link to edit Matriculacioness
    Given I am an employee user with some Expedientes
      And some of my Matriculaciones have a matricula pdf
    When I access the Matriculaciones index page
    Then I should see a link to "edit" the Matriculaciones PDF
  
  Scenario: registered users cannot see the link to edit Matriculaciones
    Given I am a registered User with some Expedientes
    When I access the Matriculaciones index page
    Then I should not see a link to "edit" the Matriculaciones PDF
  
  Scenario: registered users cannot access the edit page for Matriculaciones
    Given I am a registered User with some Expedientes
    When I access the edit page for a given Matriculacion
    Then I should be redirected to the homepage
  
  Scenario: employee users can access the edit page for Matriculaciones
    Given I am an employee user with some Expedientes
    When I access the edit page for a given Matriculacion
    Then I should be able to edit the Matriculacion
  
  Scenario: admin users can access the edit page for Matriculaciones
    Given I am an admin user
      And there are more Expedientes from other Clientes
    When I access the edit page for a given Matriculacion
    Then I should be able to edit the Matriculacion

  Scenario: admin users can access the add pdf page for Matriculaciones
    Given I am an admin user
      And there are some Expedientes without matricula
    When I want to add a PDF for those Matriculaciones
    Then I should be able to add the Matriculacion PDF

  Scenario: employee users can access the add pdf page for Matriculaciones
    Given I am an employee user
      And there are some Expedientes without matricula
    When I want to add a PDF for those Matriculaciones
    Then I should be able to add the Matriculacion PDF

  Scenario: registered users cannot access the add pdf page for Matriculaciones
    Given I am a registered User with some Expedientes
    When I access the add pdf page for a given Matriculacion
    Then I should be redirected to the homepage

  Scenario: registered users can access the pdf page for Matriculaciones
    Given I am a registered User with some Expedientes
      And some of my Matriculaciones have a matricula pdf
    When I access the Matriculaciones index page
      And I follow their matricula pdf link
    Then I should see a PDF document

  Scenario: Users can just access PDFs from their Clientes (Matriculas)
  Given I am a registered User
  When I visit the matricula PDF page for a Matriculacion of another Cliente 
  Then I should not see a PDF document
    And I should be redirected to the online homepage


  Scenario: a link to see the matricula PDF should appear if the file is in the server
    Given I am a registered User with some Expedientes
      And some of my Matriculaciones have a matricula pdf
    When I access the Matriculaciones index page
    Then I should see a link to the matricula PDF

  Scenario: no broken link but nothing should be shown if the pdf matricula file is not in the server
    Given I am a registered User with some Expedientes
      And some of my Matriculaciones have a matricula pdf
      But the pdf file is not in the server due to any reason
    When I access the Matriculaciones index page
    Then I should not see a link to the matricula PDF

  Scenario: employees can successfully update a Matriculacion adding or changing a pdf matricula file
    Given I am an employee user
      And there are some Expedientes without matricula
    When I add a PDF for those Matriculaciones
    Then the update should occur
      And the Matriculacion should be linked to that PDF

  Scenario: admin users can successfully update a Matriculacion adding or changing a pdf matricula file
    Given I am an admin user
      And there are some Expedientes without matricula
    When I add a PDF for those Matriculaciones
    Then the update should occur
      And the Matriculacion should be linked to that PDF
  
  Scenario: employees should see an error message if update fails
    Given I am an employee user
      And there are some Expedientes without matricula
    When I try to add a PDF for those Matriculaciones but fails
    Then the update should not occur
      And the Matriculacion should not be linked to that PDF

  Scenario: admin users should see an error message if update fails
    Given I am an admin user
      And there are some Expedientes without matricula
    When I try to add a PDF for those Matriculaciones but fails
    Then the update should not occur
      And the Matriculacion should not be linked to that PDF

    