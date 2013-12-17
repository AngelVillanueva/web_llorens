Feature: temporary Matricula pdfs for Matriculaciones could be uploaded in a zip file
  As an admin or employee user
  In order to improve my productivity
  I should be able to upload several temporary matricula pdfs bundled in a zip file

  After do
    Warden.test_reset! 
  end
@zip
  Scenario: Temporary matricula pdfs can be uploaded bundled in zip file
    Given I am an employee user
      And there are some Matriculaciones with pending temporary matricula pdf
    When I upload a zip file containing one or more temporary matricula pdfs
    Then a new zip file with one or more temporary matricula pdfs should be created
@zip
  Scenario: Bundled temporary matricula pdfs can be unzipped and assign
    Given I am an employee user
      And there are some Matriculaciones with pending temporary matricula pdf
      And I have created a new zipped bundled of temporary matricula pdfs
    When I unzip the bundle
    Then the matching Matriculaciones should be updated with their temporary pdfs
      And the bundle should be marked as unbundled