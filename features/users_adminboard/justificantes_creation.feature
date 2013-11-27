Feature: Justificantes creation
  As a registered User
  In order to have all my Justificantes in one place
  I should be able to add a new Justificante

After do
  Warden.test_reset! 
end

  Scenario: try to create a new Justificante missing data
    Given I am a registered User
    When I submit not all the needed information for a new Justificante
    Then a new Justificante should not be created

  Scenario: create a new Justificante
    Given I am a registered User
    When I submit all the information for a new Justificante
    Then a new Justificante should be created
@now
  Scenario: create a new Justificante during a Saturday implies an email
    Given I am a registered User
    When a new Justificante is created during a Saturday
    Then each employee on-guard should receive an email
@now
  Scenario: create a new Justificante during a Sunday implies an email
    Given I am a registered User
    When a new Justificante is created during a Sunday
    Then "angel@a.com" should receive an email