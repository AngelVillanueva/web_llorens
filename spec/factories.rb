FactoryGirl.define do
  factory :organizacion do
    nombre "Sinapse Consulting SL"
    identificador "SIN"
    cif "00000000T"
  end

  factory :cliente do
    nombre "Sinapse Consulting S.L."
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

  factory :matriculacion, class: 'Matriculacion' do
    identificador "IM-test"
    matricula "Test matriculacion"
    bastidor "ABC123M"
    comprador "Pedrito M. Compratodo"
    vendedor "Justin M. Vendemas"
    marca "BMV"
    modelo "serie M"
    fecha_alta 3.days.ago.to_date
    fecha_entra_trafico 2.days.ago.to_date
    fecha_facturacion 1.day.ago.to_date
    observaciones "Por favor, recoger"
    cliente
  end

  factory :transferencia, class: 'Transferencia' do
    identificador "IT-test"
    matricula "Test transferencia"
    bastidor "ABC123"
    comprador "Pedrito T. Compratodo"
    vendedor "Justin T. Vendemas"
    marca "BMV"
    modelo "serie T"
    fecha_alta 3.days.ago.to_date
    fecha_entra_trafico 2.days.ago.to_date
    fecha_facturacion 1.day.ago.to_date
    observaciones "Por favor, llevatelo"
    cliente
  end
  factory :justificante do
    identificador "J-test"
    nif_comprador "00000000T"
    nombre_razon_social "John E."
    primer_apellido "Cessitounj"
    segundo_apellido "Ustificante"
    provincia "Barcelona"
    municipio "Molins de Rei"
    direccion "Rambla Josep Maria Jujol, 15, 4-4"
    matricula "Test justificante"
    bastidor "ABC123"
    marca "BMV"
    modelo "serie J"
    cliente
  end
  factory :informe do
    matricula "Test informe"
    solicitante "Bush C. Oinforme"
    cliente
  end
end