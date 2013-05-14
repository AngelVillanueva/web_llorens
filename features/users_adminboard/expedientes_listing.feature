Feature: Expedientes listing
  As a User
  In order to find out the Expedientes status
  I should be able to list the Expedientes

Scenario: Expedientes index
  Given I am a User with some Expedientes
  When I access the Expedientes index page
  Then I should see a list of the Expedientes