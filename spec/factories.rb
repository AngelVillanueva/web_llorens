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
    llorens_cliente_id "444999111"
    organizacion
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
    llorens_cliente_id "444999111"
    ivtm 30.89
    created_at Matriculacion.matriculable_pdf_date.to_time+1
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
    llorens_cliente_id "444999111"
    cliente
  end
  factory :justificante do
    identificador "J-test"
    nif_comprador "07567174J"
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
  factory :mandato do
    identificador "MD-test"
    nif_comprador "07567174J"
    nombre_razon_social "John E."
    primer_apellido "CessitounMan"
    segundo_apellido "Dato"
    provincia "Barcelona"
    municipio "Molins de Rei"
    direccion "Rambla Josep Maria Jujol, 15, 4-4"
    telefono "679514899"
    matricula_bastidor "ABC123"
    marca "BMV"
    modelo "serie MD"
    cliente
  end
  factory :informe do
    matricula "Test informe"
    solicitante "Bush C. Oinforme"
    cliente
  end

  factory :aviso do
    titular "De: Quevedo"
    contenido "Un soneto me manda hacer Violante, que en mi vida me he visto en tal aprieto. 8 versos dicen que es soneto, burla burlando van los dos primeros."
    sequence( :created_at ) { |n| (1000-n).hour.ago }
  end

  factory :guardia do
    sequence( :email ) { |n| "email#{n}@llorens.com" }
  end

  factory :zip_matricula do
    zip File.new( "#{Rails.root}/spec/fixtures/my.zip" )
  end

  factory :stock_vehicle do
    sequence( :matricula ) { |n| "ABC123#{n}" }
  end


  factory :stock_vehicle_completo, class: "StockVehicle" do
    sequence( :matricula ) { |n| "ABC123#{n}" }
    particular true
    compra_venta true
    marca "SEAT"
    modelo "TOLEDO"
    sequence( :comprador ) { |n| "Comprador n#{n}" }
    ft true
    pc false
    fecha_itv 1.month.ago
    incidencia "Hay una incidencia"
    fecha_expediente_completo 5.days.ago
    fecha_documentacion_enviada 4.days.ago
    fecha_notificado_cliente 3.days.ago
    fecha_documentacion_recibida 2.days.ago
    fecha_envio_gestoria 1.days.ago
    baja_exportacion false
    fecha_entregado_david Date.today
    fecha_envio_definitiva nil
    observaciones "Un expediente completado totalmente"
  end

  factory :xml_vehicle do
    xml File.new( "#{Rails.root}/spec/fixtures/my.xml" )
    cliente
  end
end