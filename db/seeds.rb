# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Main Organizacion, app owner
llorens = Organizacion.find_or_create_by_nombre(
    nombre: "Gestoria Llorens",
    identificador: "LLORENS"
  )

# Main admin user
superadmin = Usuario.find_or_create_by_nombre(
    nombre: "Administrador",
    apellidos: "Total",
    email: "info@sinapse.es",
    password: "foobarfoo",
    password_confirmation: "foobarfoo",
    organizacion: Organizacion.find_by_identificador("LLORENS"),
    role: "admin"
  )