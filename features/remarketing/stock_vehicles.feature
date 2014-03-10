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

Scenario: Stock Vehicle page from Online index
  Given I am a registered User
    And the Cliente I belong to has 2 Stock Vehicles
  When I visit the application home page
  When I try to access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page from Online index just for my Organizacion
  Given I am a registered User
    And a Cliente I do not belong to has 2 Stock Vehicles
  When I visit the application home page
  Then I should not see any link to access a Remarketing page
    But I access the Remarketing page for the Cliente
  Then I should not see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page from Online index for admin users
  Given I am an admin user
    And a Cliente I do not belong to has 2 Stock Vehicles
  When I visit the application home page
  When I try to access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page from Online index for employees
  Given I am an employee user
    And a Cliente I do not belong to has 2 Stock Vehicles
  When I visit the application home page
  When I try to access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page is accessible for admin Users
  Given I am an admin user
    And a Cliente I do not belong to has 2 Stock Vehicles 
  When I access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page is accessible for employee Users
  Given I am an employee user
    And a Cliente I do not belong to has 2 Stock Vehicles 
  When I access the Remarketing page for the Cliente
  Then I should see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle page is just to see my own StockVehicles
  Given I am a registered User
    And a Cliente I do not belong to has 2 Stock Vehicles
  When I access the Remarketing page for the Cliente
  Then I should not see a list of my 2 Stock Vehicles

Scenario: Stock Vehicle data
  Given I am a registered User
    And the Cliente I belong to has 3 Stock Vehicles
    And the first vehicle is not sold
    And the second vehicle is sold and with status of Documentacion Enviada
    And the last vehicle is sold and with status of Finalizado
  When I access the Remarketing page for the Cliente
  Then I should see a list of my 3 Stock Vehicles
    And I should see the first one as not sold
    And I should see the second one as sold and with Documentacion Enviada
    And I should see the last one as sold and Finalizado
@current
Scenario: Stock Vehicle detail
  Given I am a registered User
    And the Cliente I belong to has 2 Stock Vehicles
  When I access the Remarketing page for the Cliente
    And I want to see the second Stock Vehicle data detail
  Then I should see all the attributes of the second Stock Vehicle
@current @javascript
Scenario: Stock Vehicle detail with javascript
  Given I am a registered User
    And the Cliente I belong to has 2 Stock Vehicles
  When I access the Remarketing page for the Cliente
    And I want to see the second Stock Vehicle data detail in the same page
  Then I should remain in the Stock Vehicles index page
    And I should see all the attributes of the second Stock Vehicle in the same page