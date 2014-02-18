@remarketing
Feature: Stock Vehicles information
  As a registered User of a Remarketed client
  In order to find out the status of my Stock Vehicles
  I should be able to see in detail all their information

After do
  Warden.test_reset! 
end

Scenario: Stock Vehicle page
  Given I am a registered User
    And the Cliente I belong to has 2 Stock Vehicles
  When I access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles