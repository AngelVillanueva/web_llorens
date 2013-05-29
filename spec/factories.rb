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

  factory :matriculacion do
    identificador "IM-test"
    matricula "Test matricula"
    bastidor "ABC123"
    comprador "Pedrito Compratodo"
    vendedor "Justin Vendemas"
    marca "BMV"
    modelo "serie 5"
    fecha_alta 3.days.ago.to_date
    fecha_entra_trafico 2.days.ago.to_date
    fecha_facturacion 1.day.ago.to_date
    observaciones "Por favor, recoger"
    organizacion
    type "matriculacion"
  end
end