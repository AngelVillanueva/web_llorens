@current
Feature: Avisos created from the admin panel
  As an admin user
  In order to let my customers know when something important happens
  I should be able to create Avisos from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an admin user can create an Aviso
    Given I am an admin user
    When I create an Aviso in the admin panel
    Then the Aviso should be created