include Warden::Test::Helpers
Warden.test_mode!

Given(/^I am a User$/) do
  # do nothing
end

Given(/^I am a registered User with some Expedientes$/) do
  usuario = FactoryGirl.create(:usuario)
  login_as(usuario, :scope => :usuario)
  Expediente.create(identificador: "IM-test", matricula: "Test matricula")
end