Feature: Stock Vehicles can be uploaded in a xml file
  As an admin or employee user
  In order to improve my productivity
  I should be able to upload several Stock Vehicles bundled in a xml file

  After do
    Warden.test_reset! 
  end
@remarketing @xml
  Scenario: Stock Vehicles can be uploaded bundled in zip file
    Given I am an employee user
    When I upload a xml file containing one or more Stock Vehicles
    Then a new xml file with one or more Stock Vehicles should be created
    # Then the new Stock Vehicles should be created
    #   And assigned to the right Cliente

# @zip
#   Scenario: Bundled temporary matricula pdfs can be unzipped and assign
#     Given I am an employee user
#       And there are some Matriculaciones with pending temporary matricula pdf
#       And I have created a new zipped bundled of temporary matricula pdfs
#     When I unzip the bundle
#     Then the matching Matriculaciones should be updated with their temporary pdfs
#       And the bundle should be marked as unbundled