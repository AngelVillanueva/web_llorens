Given(/^one of the justificantes has an attached PDF$/) do
  justificante = Justificante.find_by_matricula( "Test justificante" )
  justificante.pdf_content_type = "application/pdf"
end

Given(/^there are also Justificantes from other Clientes$/) do
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_justificantes = FactoryGirl.create( :justificante, matricula: "Justificante externo",
    cliente: acompany )
end

Given(/^there are also Justificantes from other Clientes but from my Organizacion$/) do
  o = Usuario.first.organizacion
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00", organizacion: o)
  external_justificantes = FactoryGirl.create( :justificante, matricula: "Justificante externo",
    cliente: acompany )
end

Given(/^there are also Justificantes from other Clientes of my Organizacion$/) do
  org = Organizacion.first
  cliente = FactoryGirl.create(:cliente, organizacion: org)
  justificante = FactoryGirl.create(:justificante, cliente: cliente)
end

When(/^I submit all the information for a new Justificante$/) do
  visit new_online_justificante_path
  fill_in "justificante_nif_comprador", with: "00000000T"
  fill_in "justificante_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Segundo apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "Matricula", with: "AAA"
  fill_in "Bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar justificante"
end

When(/^I submit all the information for a new Justificante for a person$/) do
  visit new_online_justificante_path
  fill_in "justificante_nif_comprador", with: "00000000T"
  fill_in "justificante_nombre_razon_social", with: "AAA"
  fill_in "Primer apellido", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "Matricula", with: "AAA"
  fill_in "Bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar justificante"
end

When(/^I submit all the information for a new Justificante for a person but without first name$/) do
  visit new_online_justificante_path
  fill_in "justificante_nif_comprador", with: "00000000T"
  fill_in "justificante_nombre_razon_social", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "Matricula", with: "AAA"
  fill_in "Bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar justificante"
end

When(/^I submit all the information for a new Justificante for a company$/) do
  visit new_online_justificante_path
  check "imacompany"
  fill_in "justificante_nif_comprador", with: "00000000T"
  fill_in "justificante_nombre_razon_social", with: "AAA"
  fill_in "Provincia", with: "AAA"
  fill_in "Municipio", with: "AAA"
  fill_in "Direccion", with: "AAA"
  fill_in "Matricula", with: "AAA"
  fill_in "Bastidor", with: "AAA"
  fill_in "Marca", with: "AAA"
  fill_in "Modelo", with: "AAA"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar justificante"
end

When(/^I submit not all the needed information for a new Justificante$/) do
  visit new_online_justificante_path
  click_button "Solicitar justificante"
end

When(/^another Justificante from my Cliente is added$/) do
  internal_justificante = FactoryGirl.create( :justificante, modelo: "Nuevo justificante interno",
    cliente: cliente )
end

When(/^I access the edit page for a given Justificante$/) do
  # Usuario.count.should eql 1
  # Justificante.count.should eql 2
  # Justificante.where(cliente_id: Usuario.first.organizacion.cliente_ids)
  visit edit_online_justificante_path(Justificante.first)
end

When(/^a new Justificante is created during a (.*?)$/) do |weekday|
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
  justificante = FactoryGirl.create( :justificante, created_at: fecha, cliente: Usuario.first.clientes.first )
  Justificante.last.created_at.to_date.wday.should eql on_week
end

When(/^a new Justificante is created a (.*?) at (\d+)\.(\d+)$/) do |day, hour, minute|
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
  justificante = FactoryGirl.create( :justificante, created_at: moment, cliente: Usuario.first.clientes.first )
end

When(/^I am going to create a new Justificante$/) do
  visit new_online_justificante_path
end

Then(/^a new Justificante should (not )?be created$/) do |negation|
  expect( page ).to have_selector( 'tr.justificante', count: negation ? 0 : 1 )
end

Then(/^I should see a list of the Justificantes$/) do
  page.should have_title( I18n.t( "Justificantes" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  justificantes = usuario.justificantes
  justificantes.each do |justificante|
    page.should have_selector( 'td', text: justificante.matricula.upcase )
  end
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
end

Then(/^I should see a list of the Justificantes with matricula in uppercase$/) do
  page.should have_title( I18n.t( "Justificantes" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  justificantes = usuario.justificantes
  justificantes.each do |justificante|
    page.should have_selector( 'td', text: justificante.matricula.upcase )
  end
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
end

Then(/^I should see a list of all the Justificantes$/) do
  page.should have_title( I18n.t( "Justificantes" ) )
  Justificante.count.should eql 1
  expect( page ).to have_selector( 'tr.justificante', count: 1 )
end

Then(/^the first Justificante should be the most urgent one$/) do
  expect( first( 'tr.justificante' ) ).to have_selector( 'td', text: "Otro justificante".upcase )
end

Then(/^I should see just the list of the Justificantes from my Cliente$/) do
  expect( page ).to have_selector( 'tr.justificante', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Justificante externo" )
end

Then(/^I should (not )?see the list of all the Justificantes from my Organizacion$/) do |negation|
  rows = Justificante.where(cliente_id: Organizacion.first.cliente_ids).count
  if negation
    expect( page ).to_not have_selector( 'tr.justificante', count: rows )
  else
    expect( page ).to have_selector( 'tr.justificante', count: rows )
  end
end

Then(/^I should see the list of the Justificantes updated and sorted without reloading the page$/) do
  using_wait_time 20 do
    expect( page ).to have_selector( 'tr.justificante', count: 3 )
    expect( first( '#justificantes tr.justificante' ) ).to have_selector( 'td', text: "Nuevo justificante interno" )
  end
end

Then(/^I should (not )?see a link to edit the Justificantes$/) do |negation|
  if negation
    rows = 0
  else
    rows = Justificante.count
  end
  expect( page ).to have_selector( 'i.toedit', count: rows )
end

Then(/^I should be able to edit the Justificante$/) do
  page.should have_title( I18n.t( "Editar Justificante Profesional" ) )
  page.should have_selector( "form.justificantes" )
end

Then(/^I should see the newly created justificante$/) do
  expect( page ).to have_selector( 'tr.justificante', count: 1 )
  expect( first( '#justificantes tr.justificante' ) ).to have_selector( 'td', text: "Test justificante".upcase )
end

Then(/^I should be reminded to fulfill the first name field to create the Justificante$/) do
  expect( page ).to have_selector( '.modal-body p', text: I18n.t( "Primer apellido obligatorio para personas" ) )
end