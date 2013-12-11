Feature: Matricula PDF managed from the admin panel
  As an employee
  In order to quickly complete the Matriculacion information
  I should be able to upload the Matricula PDF from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an employee user can access Matriculaciones admin management
    Given I am an employee user
    When I access the admin panel
    Then I should see the Matriculaciones menu link