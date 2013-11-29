Feature: Contact Form
  As the website owner
  In order to enable a communication channel with my prospects
  I should be able to receive contact messages from a web form

  Scenario: A contact form is available
    Given I am a User
    When I visit the contact page
    Then I should see a Contact form

  Scenario: All fields are mandatory
    Given I am a User
    When I visit the contact page
      And I submit the form without some of the fields
    Then I should see an error message

  Scenario: A blank form should also show an error message
    Given I am a User
    When I visit the contact page
      And I submit the form with all of the fields as blanks
    Then I should see an error message

  Scenario: error message should dissapear if the user visits a different page
    Given I am a User
    When I visit the contact page
      And I submit the form with all of the fields as blanks
      And I visit a different page
    Then I should not see an error message

  Scenario: the form cannot be submitted without checking the TOS box
    Given I am a User
    When I try to submit the contact form without checking the TOS box
    Then I should see an error message
@email @javascript
  Scenario: a complete contact request submission should generate two emails
    Given I am a User
    When I submit the form with all the fields
    Then I should not see an error message
      And "employee@llorens.com" should receive an email
      And "requester@example.com" should receive an email