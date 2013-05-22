FactoryGirl.define do
  factory :usuario do
    nombre "Angel"
    apellidos "Villanueva Perez"
    organizacion "Sinapse Consulting SL"
    identificador_organizacion "SIN"
    email "info@sinapse.es"
    password "foobarfoo"
    password_confirmation "foobarfoo"
  end 
end