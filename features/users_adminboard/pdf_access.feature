Feature: PDF access
  As a User
  In order to read it easily
  I should be able to access the documentation in PDF

After do
  Warden.test_reset! 
end

Scenario: Generating the PDF
  Given I am a registered User with some Expedientes
    And I visit the Matriculacion index page
    Then show me the page
  When I follow a PDF link
  Then I should see a PDF document
    And the PDF should be the one for the related Item
    And the first page from the original PDF should not appear

Scenario: Users can just access PDFs from their Organizaciones
  Given I am a registered User
  When I visit the Expediente PDF page for an Expediente of another Organizacion 
  Then I should not see a PDF document
      And I should be redirected to the homepage