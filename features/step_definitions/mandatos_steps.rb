Given(/^one of the mandatos has an attached PDF$/) do
  mandato = Mandato.find_by_matricula( "Test mandato" )
  mandato.pdf_content_type = "application/pdf"
end

Given(/^there are also Mandatos from other Clientes$/) do
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_mandatos = FactoryGirl.create( :mandato, matricula_bastidor: "Mandato externo",
    cliente: acompany )
end

Given(/^there are also Mandatos from other Clientes but from my Organizacion$/) do
  o = Usuario.first.organizacion
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00", organizacion: o)
  external_mandatos = FactoryGirl.create( :mandato, matricula_bastidor: "Mandato externo",
    cliente: acompany )
end

Given(/^there are also Mandatos from other Clientes of my Organizacion$/) do
  org = Organizacion.first
  cliente = FactoryGirl.create(:cliente, organizacion: org)
  mandato = FactoryGirl.create(:mandato, cliente: cliente)
end

When(/^I submit all the information for a new Mandato$/) do
  visit new_online_mandato_path
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Segundo apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a person$/) do
  visit new_online_mandato_path
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a used vehicle$/) do
  visit new_online_mandato_path
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a new vehicle$/) do
  visit new_online_mandato_path
  check "imanuevo"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a person but without first name$/) do
  visit new_online_mandato_path
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a used vehicle but without matricula$/) do
  visit new_online_mandato_path
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a new vehicle but without bastidor$/) do
  visit new_online_mandato_path
  check "imanuevo"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a company$/) do
  visit new_online_mandato_path
  check "imacompany"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "mandato_repre_nombre", with: "AAA"
  fill_in "mandato_repre_apellido_1", with: "AAA"
  fill_in "mandato_nif_representante", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a company without name representante$/) do
  visit new_online_mandato_path
  check "imacompany"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "mandato_repre_apellido_1", with: "AAA"
  fill_in "mandato_nif_representante", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a company without first name representante$/) do
  visit new_online_mandato_path
  check "imacompany"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "mandato_repre_nombre", with: "AAA"
  fill_in "mandato_nif_representante", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit all the information for a new Mandato for a company without nif representante$/) do
  visit new_online_mandato_path
  check "imacompany"
  fill_in "mandato_nif_comprador", with: "00000000T"
  fill_in "mandato_nombre_razon_social", with: "AAA"
  fill_in "mandato_repre_nombre", with: "AAA"
  fill_in "mandato_repre_apellido_1", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "mandato_telefono", with: "666555777"
  fill_in "mandato_matricula_bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar mandato"
end

When(/^I submit not all the needed information for a new Mandato$/) do
  visit new_online_mandato_path
  click_button "Solicitar mandato"
end

When(/^another Mandato from my Cliente is added$/) do
  internal_mandato = FactoryGirl.create( :mandato, modelo: "Nuevo mandato interno",
    cliente: cliente )
end

When(/^I access the edit page for a given Mandato$/) do
  # Usuario.count.should eql 1
  # Mandato.count.should eql 2
  # Mandato.where(cliente_id: Usuario.first.organizacion.cliente_ids)
  visit edit_online_mandato_path(Mandato.first)
end

When(/^a new Mandato is created during a (.*?)$/) do |weekday|
  guardia1 = FactoryGirl.create( :guardia )
  guardia2 = FactoryGirl.create( :guardia )
  if weekday == "Saturday"
    some_day = "23-11-2013" # it was a Saturday
    on_week = 6 # wday for Saturday is 6
  elsif weekday == "Sunday"
    some_day = "24-11-2013" # it was a Sunday
    on_week = 0 # wday for Sunday is 0
  elsif weekday == "Monday"
    some_day = "25-11-2013" # it was a Sunday
    on_week = 1 # wday for Sunday is 0
  elsif weekday == "Tuesday"
    some_day = "26-11-2013" # it was a Sunday
    on_week = 2 # wday for Sunday is 0
  end
  fecha = Date.parse( some_day ) 
  mandato = FactoryGirl.create( :mandato, created_at: fecha, cliente: Usuario.first.clientes.first )
  Mandato.last.created_at.to_date.wday.should eql on_week
end

When(/^a new Mandato is created a (.*?) at (\d+)\.(\d+)$/) do |day, hour, minute|
  guardia1 = FactoryGirl.create( :guardia )
  guardia2 = FactoryGirl.create( :guardia )
  case day
    when "Monday"
      a_day = "27-01-2014"
    when "Tuesday"
      a_day = "28-01-2014"
    when "Wednesday"
      a_day = "29-01-2014"
    when "Thursday"
      a_day = "30-01-2014"
    when "Friday"
      a_day = "31-01-2014"
    when "Saturday"
      a_day = "01-02-2014"
    when "Sunday"
      a_day = "02-02-2014"
  end
  moment = "#{a_day} #{hour}:#{minute}"
  mandato = FactoryGirl.create( :mandato, created_at: moment, cliente: Usuario.first.clientes.first )
end

When(/^I am going to create a new Mandato$/) do
  visit new_online_mandato_path
end

Then(/^a new Mandato should (not )?be created$/) do |negation|
  expect( page ).to have_selector( 'tr.mandato', count: negation ? 0 : 1 )
end

Then(/^I should see a list of the Mandatos$/) do
  page.should have_title( I18n.t( "Mandatos" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  mandatos = usuario.mandatos
  mandatos.each do |mandato|
    page.should have_selector( 'td', text: mandato.matricula_bastidor.upcase )
  end
  expect( page ).to have_selector( 'tr.mandato', count: 2 )
end

Then(/^I should see a list of the Mandatos with matricula in uppercase$/) do
  page.should have_title( I18n.t( "Mandatos" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  mandatos = usuario.mandatos
  mandatos.each do |mandato|
    page.should have_selector( 'td', text: mandato.matricula_bastidor.upcase )
  end
  expect( page ).to have_selector( 'tr.mandato', count: 2 )
end

Then(/^I should see a list of all the Mandatos$/) do
  page.should have_title( I18n.t( "Mandatos" ) )
  Mandato.count.should eql 1
  expect( page ).to have_selector( 'tr.mandato', count: 1 )
end

Then(/^the first Mandato should be the most urgent one$/) do
  expect( first( 'tr.mandato' ) ).to have_selector( 'td', text: "Otro mandato".upcase )
end

Then(/^I should see just the list of the Mandatos from my Cliente$/) do
  expect( page ).to have_selector( 'tr.mandato', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Mandato externo" )
end

Then(/^I should (not )?see the list of all the Mandatos from my Organizacion$/) do |negation|
  rows = Mandato.where(cliente_id: Organizacion.first.cliente_ids).count
  if negation
    expect( page ).to_not have_selector( 'tr.mandato', count: rows )
  else
    expect( page ).to have_selector( 'tr.mandato', count: rows )
  end
end

Then(/^I should see the list of the Mandatos updated and sorted without reloading the page$/) do
  using_wait_time 20 do
    expect( page ).to have_selector( 'tr.mandato', count: 3 )
    expect( first( '#mandatos tr.mandato' ) ).to have_selector( 'td', text: "Nuevo mandato interno" )
  end
end

Then(/^I should (not )?see a link to edit the Mandatos$/) do |negation|
  if negation
    rows = 0
  else
    rows = Mandato.count
  end
  expect( page ).to have_selector( 'i.toedit', count: rows )
end

Then(/^I should be able to edit the Mandato$/) do
  page.should have_title( I18n.t( "Editar Mandato" ) )
  page.should have_selector( "form.mandatos" )
end

Then(/^I should see the newly created mandato$/) do
  expect( page ).to have_selector( 'tr.mandato', count: 1 )
  expect( first( '#mandatos tr.mandato' ) ).to have_selector( 'td', text: "Test mandato".upcase )
end

Then(/^I should be reminded to fulfill the first name field to create the Mandato$/) do
  expect( page ).to have_selector( '.modal-body p', text: I18n.t( "Primer apellido obligatorio para personas" ) )
end

Then(/^I should be reminded to fulfill the matricula field to create the Mandato$/) do
  expect( page ).to have_selector( '.modal-body p', text: I18n.t( "Matricula obligatoria en vehiculos matriculados" ) )
end

Then(/^I should be reminded to fulfill the bastidor field to create the Mandato$/) do
  expect( page ).to have_selector( '.modal-body p', text: I18n.t( "Bastidor obligatorio en vehiculos sin matricular" ) )
end

Then(/^I should be reminded to fulfill the representante data fields to create the Mandato$/) do
  expect( page ).to have_selector( '.modal-body p', text: I18n.t( "Representante obligatorio para empresas" ) )
end