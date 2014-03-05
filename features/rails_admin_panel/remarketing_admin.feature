@remarketing @admin
Feature: StockVehicle managed from the admin panel
  As an authorized employee
  In order to quickly complete the StockVehicle information
  I should be able to manage the Stock vehicles from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an employee user can access StockVehicle admin management
    Given I am an admin user
    When I access the admin panel
    Then I should see the StockVehicles menu link

  Scenario: an employee user can not access StockVehicle admin management
    Given I am an employee user
    When I access the admin panel
    Then I should not see the StockVehicles menu link

  Scenario: an authorized employee user can access StockVehicle admin management
    Given I am a remarketing user
    When I access the admin panel
    Then I should see the StockVehicles menu link

  Scenario: an authorized employee user can just access StockVehicle admin management
    Given I am a remarketing user
    When I access the admin panel
    Then I should not see the Matriculaciones menu link
    Then I should not see the Justificantes menu link
    Then I should not see the Informes menu link
    Then I should not see the ZipMatriculas menu link
    Then I should not see the Configuration menu link