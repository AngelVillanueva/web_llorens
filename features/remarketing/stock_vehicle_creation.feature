@remarketing @wip
Feature: Stock Vehicles creation
  As a registered User of a Remarketed client
  In order to maintain the information of my Stock Vehicles
  I should be able to add a new Stock Vehicle

After do
  Warden.test_reset! 
end
  @current
  Scenario: Creating a new record
    Given I am a registered User
      And the Cliente I belong to has 2 Stock Vehicles
    When I access the page to create a new Stock Vehicle for the Cliente
      And I submit the form with all the information for the new Stock Vehicle
    Then the new Stock Vehicle should be created
      And the Cliente I belong to should have 3 Stock Vehicles