Feature: restricted access
  In order to maintain my data secure
  As Gestoria Llorens
  I want that just registered users could access the application

  Scenario: a non registered user cannot access the application
    Given I am a User
    When I visit the application home page
    Then I should not be able to access the application

  Scenario: a registered user can access the application
    Given I am a registered User
    When I visit the application home page
    Then I should be able to access the application
      And I should see the following links
        |           LINKS             |
        |      Matriculación (VN)     |
        | Transferencias y bajas (VO) |
        |  Solicitud de Justificantes |
        |    Solicitud de Mandatos    |
        |    Solicitud de Informes    |