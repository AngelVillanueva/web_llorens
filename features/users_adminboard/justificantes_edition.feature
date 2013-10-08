Feature: Justificantes edition
  As an admin or employee User
  In order to complete my Justificantes
  I should be able to edit an existing Justificante

After do
  Warden.test_reset! 
end
  
  Scenario: admin users can see the link to edit Justificantes
    Given I am an admin user
      And there are also Justificantes from other Clientes
    When I access the Justificantes index page
    Then I should see a link to edit the Justificantes
  
  Scenario: employee users can see the link to edit Justificantes
    Given I am an employee user
      And there are also Justificantes from other Clientes
    When I access the Justificantes index page
    Then I should see a link to edit the Justificantes

  Scenario: registered users cannot see the link to edit Justificantes
    Given I am a registered User with some Justificantes
    When I access the Justificantes index page
    Then I should not see a link to edit the Justificantes

  @wip
  Scenario: registered users cannot access the edit page for Justificantes
    Given I am a registered User with some Justificantes
    When I access the edit page for a given Justificantes
    Then I should be redirected to the homepage