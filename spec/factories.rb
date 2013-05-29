FactoryGirl.define do
  factory :organizacion do
    nombre "Sinapse Consulting SL"
    identificador "SIN"
    cif "00000000T"
  end

  factory :usuario do
    nombre "Angel"
    apellidos "Villanueva Perez"
    email "info@sinapse.es"
    password "foobarfoo"
    password_confirmation "foobarfoo"
    organizacion
  end

  factory :expediente do
    identificador "IM-test"
    matricula "Test matricula"
    organizacion
  end
end