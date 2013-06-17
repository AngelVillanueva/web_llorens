include Warden::Test::Helpers
Warden.test_mode!

Given(/^I am a User$/) do
  # do nothing
end

Given(/^I am a registered User$/) do
  login_as( usuario, scope: :usuario )
end

Given(/^I am a registered User with some Expedientes$/) do
  login_as( usuario, :scope => :usuario )
  matriculacion
  transferencia
end

Given(/^I am a registered User with some Informes$/) do
  login_as( usuario, :scope => :usuario )
  informe
  informe_2 = FactoryGirl.create( :informe, matricula: "Otro informe",
    organizacion: organizacion )
end