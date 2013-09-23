include Warden::Test::Helpers
Warden.test_mode!

Given(/^I am a User$/) do
  # do nothing
end

Given(/^I am a registered User$/) do
  login_as( usuario, scope: :usuario )
end

Given(/^I am an admin user$/) do
  login_as( admin, scope: :usuario )
end

Given(/^I am a registered User with some Expedientes$/) do
  login_as( usuario, :scope => :usuario )
  matriculacion
  transferencia
end

Given(/^I am a registered User with some Expedientes but without documents$/) do
  login_as( usuario, :scope => :usuario )
  matriculacion_incomplete
  transferencia_incomplete
end

Given(/^I am a registered User with some Justificantes$/) do
  login_as( usuario, :scope => :usuario )
  justificante
  justificante_2 = FactoryGirl.create( :justificante, matricula: "Otro justificante",
    cliente: cliente )
end

Given(/^I am a registered User with some Informes$/) do
  login_as( usuario, :scope => :usuario )
  informe
  informe_2 = FactoryGirl.create( :informe, matricula: "Otro informe",
    cliente: cliente )
end