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
end