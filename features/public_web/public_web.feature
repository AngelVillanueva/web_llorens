@public

Feature: new Sales contact
  As a web visitor
  I should be able to see the new sales person contact information
  In order to contact the Company

  Scenario: a visitor can see the new sales contact information
    Given I am a User
    When I visit the contact page
    Then I should see the new sales contact information