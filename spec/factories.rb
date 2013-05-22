FactoryGirl.define do
  factory :usuario do
    nombre "Angel"
    apellidos "Villanueva Perez"
    email "info@sinapse.es"
    password "foobarfoo"
    password_confirmation "foobarfoo"
    organizacion_id 1
  end 
end