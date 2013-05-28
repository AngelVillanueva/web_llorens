include Warden::Test::Helpers
Warden.test_mode!

Given(/^I am a User$/) do
  # do nothing
end

Given(/^I am a registered User$/) do
  login_as( usuario, scope: :usuario )
end

Given(/^I am a registered User with some Expedientes$/) do
  login_as(usuario, :scope => :usuario)
  organizacion = Usuario.last.organizacion_id
  Expediente.create(identificador: "IM-test", matricula: "Test matricula", organizacion_id: organizacion)
end