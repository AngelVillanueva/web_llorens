Feature: Expediente detail
  As a registered User
  In order to see more about an Expediente
  I should be able to see in detail all its information

After do
  Warden.test_reset! 
end

Scenario: Expediente detail page
  Given I am a registered User with some Expedientes
  When I access the page for the first Expediente
  Then I should see a detail of that Expediente

Scenario: Expediente detail page is just accessible by Usuarios from its Organizacion
  Given I am a registered User with some Expedientes
    And there are more Expedientes from other Organizaciones
    And there are more Expedientes from other Clientes
  When I access the page for the second Expediente
  Then I should not see a detail of that Expediente