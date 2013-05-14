Feature: PDF access
  As a User
  In order to read it easily
  I should be able to access the documentation in PDF 

Scenario: Generating the PDF
  Given I am a User with some Expedientes
    And I visit the Expediente index page
  When I follow a PDF link
  Then I should see a PDF document
    And the PDF should be the one for the related Item
    And the first page from the original PDF should not appear