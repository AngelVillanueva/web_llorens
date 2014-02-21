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

@remarketing @xml
  Scenario: Xml Vehicle files can be processed to assign new Stock Vehicles
    Given I am an employee user
      And I have created a new Xml Vehicle file
    When I process the xml file
    Then the new Stock Vehicles should be created
      And assigned to the right Cliente
      And the xml file should be marked as processed