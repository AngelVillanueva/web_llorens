Given(/^I am a User$/) do
  # do nothing
end

Given(/^I am a User with some Expedientes$/) do
  Expediente.create(identificador: "IM-test", matricula: "Test matricula")
end