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

  Scenario: default titular for an Aviso is "Aviso"
    Given I am a registered User
      And there is one Aviso created without titular
    When I visit the application home page
    Then I should see the Aviso with "Aviso" as the titular

  Scenario: default titular for an Aviso is "Aviso" also when empty
    Given I am a registered User
      And there is one Aviso created with an empty titular
    When I visit the application home page
    Then I should see the Aviso with "Aviso" as the titular

  Scenario: users see Avisos in the homepage of Llorens online
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page
    Then I should see the Aviso

  Scenario: Avisos with an expired maximum date should not be shown
    Given I am a registered User
      And there is one Aviso created
      But its maximum date has expired
    When I visit the application home page
    Then I should not see the Aviso

  Scenario: Avisos with an expired maximum date should be deleted as well
    Given I am a registered User with no role
      And there is one Aviso created
      But its maximum date has expired
    When I visit the application home page and log in
    Then the Aviso should be deleted

  Scenario: Avisos with a relative maximum date should not be shown
    Given I am a registered User with no role
      And there is one Aviso created
      But its relative maximum date has been reached
    When I visit the application home page and log in
    Then I should not see the Aviso

  Scenario: Avisos with a relative maximum date should be deleted as well
    Given I am a registered User with no role
      And there is one Aviso created
      But its relative maximum date has been reached
    When I visit the application home page and log in
    Then the Aviso should be deleted

@javascript
  Scenario: users can close Avisos when shown
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page
    Then I should see the Aviso
      And I should be able to close the Aviso

@javascript
  Scenario: users can see all existing Avisos
    Given I am a registered User
      And there are two Avisos created
    When I visit the application home page
    Then I should see the first Aviso
      And I should be able to see the second Aviso also

  Scenario: Avisos should be shown just once per session
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page per second time during the same session
    Then I should not see the Aviso

@wip @javascript
  Scenario: Not seen Avisos should be shown when visit the home page per second time 
    Given I am a registered User
      And there are two Avisos created
    When I visit the application home page
    Then I should see the first Aviso
      And I should be able to close the Aviso
    When I visit the application home page
    Then I should be able to see the second Aviso
