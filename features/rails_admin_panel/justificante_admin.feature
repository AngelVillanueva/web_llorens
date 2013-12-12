Feature: Justificante PDF managed from the admin panel
  As an employee
  In order to quickly complete the Justificante information
  I should be able to upload the Justificante PDF from the admin panel

  After do
    Warden.test_reset! 
  end

  Scenario: an employee user can access Justificantes admin management
    Given I am an employee user
    When I access the admin panel
    Then I should see the Justificantes menu link