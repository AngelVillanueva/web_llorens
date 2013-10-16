Feature: PDF access
  As a User
  In order to read it easily
  I should be able to access the documentation in PDF

After do
  Warden.test_reset! 
end

@pdf
Scenario: Generating the PDF
  Given I am a registered User with some Expedientes
    And I visit the Matriculacion index page
  When I follow a PDF link
  Then I should see a PDF document
    And the PDF should be the one for the related Item
    And the first page from the original PDF should not appear

@pdf
Scenario: Users can just access PDFs from their Clientes (Expedientes)
  Given I am a registered User
  When I visit the Expediente PDF page for an Expediente of another Cliente 
  Then I should not see a PDF document
    And I should be redirected to the online homepage

@pdf @current
Scenario: Users can just access PDFs from their Clientes (Justificantes)
  Given I am a registered User
  When I visit the Justificante PDF page for a Justificante of another Cliente 
  Then I should not see a PDF document
    And I should be redirected to the online homepage

@pdf
Scenario: Users can just access PDFs from their Clientes (Informes)
  Given I am a registered User
  When I visit the Informe PDF page for a Informe of another Cliente 
  Then I should not see a PDF document
    And I should be redirected to the online homepage

# disabled as no link appears if the document is not on the server
@wip
Scenario: Accessing not existing PDFs
  Given I am a registered User with some Expedientes but without documents
    And I visit the Matriculacion index page
  When I follow a PDF link
  Then I should see a PDF document
    And the PDF should be the one for missing document case