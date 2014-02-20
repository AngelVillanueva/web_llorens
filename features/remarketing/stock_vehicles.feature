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

Scenario: Stock Vehicle data
  Given I am a registered User
    And the Cliente I belong to has 3 Stock Vehicles
    And the first vehicle is not sold
    And the second vehicle is sold and with status of Documentacion Enviada
    And the last vehicle is sold and with status of Finalizado
  When I access the Remarketing page for the Cliente
  Then I should see a list of my 3 Stock Vehicles
    And I should see the first one as not sold