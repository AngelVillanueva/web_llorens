@admin
Feature: Configuration managed from the admin panel
  As an employee
  In order to quickly complete the application Configuration
  I should be able to manage the Configuration options from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an admin user can access Configuration admin management
    Given I am an admin user
    When I access the admin panel
    Then I should see the Configuration menu link

  Scenario: an employee user can access Configuration admin management
    Given I am an employee user
    When I access the admin panel
    Then I should see the Configuration menu link