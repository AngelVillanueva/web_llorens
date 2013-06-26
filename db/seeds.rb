# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org_0 = Organizacion.create(
  nombre: "Gestoria Llorens",
  identificador: "GLL",
  cif: "00000000T"
  )


org_1 = Organizacion.create(
  nombre: "Organizacion 1",
  identificador: "ORG-1",
  cif: "00000000T"
  )

org_2 = Organizacion.create(
  nombre: "Organizacion 2",
  identificador: "ORG-2",
  cif: "00000000T"
  )

cli_1 = Cliente.create(
  nombre: "Sinapse Consulting SL",
  identificador: "SIN",
  cif: "00000000T",
  organizacion: org_1
  )

cli_2 = Cliente.create(
  nombre: "Sinapse 2000 SL",
  identificador: "SIN-2",
  cif: "00000000T",
  organizacion: org_1
  )

cli_3 = Cliente.create(
  nombre: "Univac SL",
  identificador: "UNI",
  cif: "00000000T",
  organizacion: org_2
  )

cli_4 = Cliente.create(
  nombre: "Univac 2000 SL",
  identificador: "UNI-2",
  cif: "00000000T",
  organizacion: org_2
  )

user_1 = Usuario.create(
  nombre: "Angel",
  apellidos: "Villanueva",
  email: "avillanueva@sinapse.es",
  password: "foobarfoo",
  password_confirmation: "foobarfoo",
  organizacion: org_1
  )

user_1.clientes << cli_1

user_2 = Usuario.create(
  nombre: "Elance",
  apellidos: "Villanueva",
  email: "elance@sinapse.es",
  password: "foobarfoo",
  password_confirmation: "foobarfoo",
  organizacion: org_1
  )

user_2.clientes << cli_2

user_3 = Usuario.create(
  nombre: "Pepon",
  apellidos: "Briales",
  email: "pepon@univac.com",
  password: "foobarfoo",
  password_confirmation: "foobarfoo",
  organizacion: org_2
  )

user_3.clientes << cli_3
user_3.clientes << cli_4

user_4 = Usuario.create(
  nombre: "Administrador",
  apellidos: "Total",
  email: "info@sinapse.es",
  password: "foobarfoo",
  password_confirmation: "foobarfoo",
  organizacion: org_0,
  role: "admin"
  )

5.times do
  Matriculacion.create!(
    identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
    matricula: Faker::Lorem.characters(6).upcase,
    bastidor: Faker::Lorem.characters(17).upcase,
    comprador: Faker::Name.name,
    vendedor: Faker::Name.name,
    marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
    modelo: Faker::Lorem.word.capitalize,
    fecha_alta: fa = Random.new.rand(10).days.ago.to_date,
    fecha_entra_trafico: ft = fa + Random.new.rand(3),
    fecha_facturacion: ff = ft + Random.new.rand(2),
    observaciones: Faker::Lorem.sentence,
    cliente: [cli_1, cli_2, cli_3, cli_4].sample
  )
end

5.times do
  Transferencia.create!(
    identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
    matricula: Faker::Lorem.characters(6).upcase,
    bastidor: Faker::Lorem.characters(17).upcase,
    comprador: Faker::Name.name,
    vendedor: Faker::Name.name,
    marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
    modelo: Faker::Lorem.word.capitalize,
    fecha_alta: fa = Random.new.rand(10).days.ago.to_date,
    fecha_entra_trafico: ft = fa + Random.new.rand(3),
    fecha_facturacion: ff = ft + Random.new.rand(2),
    observaciones: Faker::Lorem.sentence,
    cliente: [cli_1, cli_2, cli_3, cli_4].sample
  )
end

10.times do
  Justificante.create(
    identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
    nif_comprador: "00000000T",
    nombre_razon_social: Faker::Name.first_name,
    primer_apellido: Faker::Name.last_name,
    segundo_apellido: Faker::Name.last_name,
    provincia: Faker::Address.state,
    municipio: Faker::Address.city,
    direccion: Faker::Address.street_address,
    matricula: Faker::Lorem.characters(6).upcase,
    bastidor: Faker::Lorem.characters(17).upcase,
    marca: ["BMW", "Seat", "Opel", "Citroen", "Mercedes"].sample,
    modelo: Faker::Lorem.word.capitalize,
    cliente: [cli_1, cli_2, cli_3, cli_4].sample
  )
end

10.times do
  Informe.create(
    identificador: "#{Faker::Lorem.characters(3).upcase}-#{Faker::Lorem.characters(3).upcase}",
    solicitante: Faker::Name.name,
    matricula: Faker::Lorem.characters(6).upcase,
    cliente: [cli_1, cli_2, cli_3, cli_4].sample
  )
end
