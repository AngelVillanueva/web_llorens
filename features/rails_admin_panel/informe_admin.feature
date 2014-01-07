Feature: Informe PDF managed from the admin panel
  As an employee
  In order to quickly complete the Informe information
  I should be able to upload the Informe PDF from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an employee user can access Informes admin management
    Given I am an employee user
    When I access the admin panel
    Then I should see the Informes menu link