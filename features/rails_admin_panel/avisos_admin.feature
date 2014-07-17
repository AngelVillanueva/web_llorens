Feature: Avisos created from the admin panel
  As an admin user
  In order to let my customers know when something important happens
  I should be able to create Avisos from the admin panel

  After do
    Warden.test_reset! 
  end
@avisos
  Scenario: an admin user can create an Aviso
    Given I am an admin user
    When I create an Aviso in the admin panel
    Then the Aviso should be created
@avisos
  Scenario: default titular for an Aviso is "Aviso"
    Given I am a registered User
      And there is one Aviso created without titular
    When I visit the application home page
    Then I should see the Aviso with "Aviso" as the titular
@avisos
  Scenario: default titular for an Aviso is "Aviso" also when empty
    Given I am a registered User
      And there is one Aviso created with an empty titular
    When I visit the application home page
    Then I should see the Aviso with "Aviso" as the titular
@avisos
  Scenario: users see Avisos in the homepage of Llorens online
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page
    Then I should see the Aviso
@avisos @avisos2 @javascript
  Scenario: new Avisos should be auto pulled for already connected users
    Given I am a registered User
    When I visit the application home page
      And there is one Aviso created
    Then I should see the newly created Aviso
      And there is another Aviso created
    Then I should see the latest created Aviso
@avisos @avisos2 @javascript
  Scenario: new Avisos should be auto pulled just once per page
    Given I am a registered User
    When I visit the application home page
      And there is one Aviso created
    Then I should see the newly created Aviso
      And if I stay in the same page
      And there is another Aviso created
    Then I should see the latest created Aviso
    Then I should not see the newly created Aviso twice
@avisos @avisos2 @javascript @wip
  Scenario: auto pulled new Avisos should not included the ones shown in the lightbox
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page
      And there is one Aviso created
    Then I should see the newly created Aviso
      But I should not see the Aviso previously shown in the lightbox
@avisos @avisos2 @javascript @wip
  Scenario: auto reload of the page should not cause an Aviso to be lost
    Given I am a registered User
    When I visit the Justificantes index page
      And there is one Aviso created
    Then I should see the newly created Aviso
      And if I do not close the Aviso
      And the page is auto reloaded
    Then I should see the newly created Aviso

@avisos
  Scenario: Avisos with an expired maximum date should not be shown
    Given I am a registered User
      And there is one Aviso created
      But its maximum date has expired
    When I visit the application home page
    Then I should not see the Aviso
@avisos
  Scenario: Avisos with an expired maximum date should be deleted as well
    Given I am a registered User with no role
      And there is one Aviso created
      But its maximum date has expired
    When I visit the application home page and log in
    Then the Aviso should be deleted
@avisos
  Scenario: Avisos with a relative maximum date should not be shown
    Given I am a registered User with no role
      And there is one Aviso created
      But its relative maximum date has been reached
    When I visit the application home page and log in
    Then I should not see the Aviso
@avisos
  Scenario: Avisos with a relative maximum date should be deleted as well
    Given I am a registered User with no role
      And there is one Aviso created
      But its relative maximum date has been reached
    When I visit the application home page and log in
    Then the Aviso should be deleted

@avisos @javascript
  Scenario: users can close Avisos when shown
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page
    Then I should see the Aviso
      And I should be able to close the Aviso

@avisos @javascript
  Scenario: users can see all existing Avisos
    Given I am a registered User
      And there are two Avisos created
    When I visit the application home page
    Then I should see the first Aviso
      And I should be able to see the second Aviso also
@avisos
  Scenario: Avisos should be shown just once per session
    Given I am a registered User
      And there is one Aviso created
    When I visit the application home page per second time during the same session
    Then I should not see the Aviso

@avisos @wip @javascript
  Scenario: Not seen Avisos should be shown when visit the home page per second time 
    Given I am a registered User
      And there are two Avisos created
    When I visit the application home page
    Then I should see the first Aviso
      And I should be able to close the Aviso
    When I visit the application home page
    Then I should be able to see the second Aviso
@avisos
  Scenario: Avisos should be shown following the admin defined order
    Given I am a registered User
      And there are two Avisos created
      And the admin user has reordered them
    When I visit the application home page
    Then I should see the Avisos in the admin user defined order
@avisos
  Scenario: a new Aviso with informed sorting_order changes the sorting_order of all affected avisos
    Given I am an admin user
    When I create a new Aviso with the same sorting_order than a previous Aviso
    Then the previous Aviso should change its sorting_order by 1
      And all the following Avisos should also change its sorting_order by 1
      But the non affected Avisos should not change its sorting_order

