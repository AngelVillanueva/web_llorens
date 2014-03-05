@admin
Feature: ZipMatricula managed from the admin panel
  As an employee
  In order to quickly complete the Expedientes information
  I should be able to upload the ZipMatricula from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an admin user can access ZipMatriculas admin management
    Given I am an admin user
    When I access the admin panel
    Then I should see the ZipMatriculas menu link

  Scenario: an employee user can access ZipMatriculas admin management
    Given I am an employee user
    When I access the admin panel
    Then I should see the ZipMatriculas menu link