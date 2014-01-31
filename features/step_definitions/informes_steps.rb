Given(/^one of the informes has an attached PDF$/) do
  informe = Informe.find_by_matricula( "Test informe" )
  informe.pdf_content_type = "application/pdf"
end

Given(/^there are also Informes from other Clientes$/) do
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00")
  external_informe = FactoryGirl.create( :informe, matricula: "Informe externo",
    cliente: acompany )
end

Given(/^there are also Informes from other Clientes but from my Organizacion$/) do
  o = Usuario.first.organizacion
  acompany = FactoryGirl.create( :cliente, nombre: "Company",
    identificador: "ORG", cif: "00", organizacion: o)
  external_informe = FactoryGirl.create( :informe, matricula: "Informe externo",
    cliente: acompany )
end

Given(/^there are also Informes from other Clientes of my Organizacion$/) do
  org = Organizacion.first
  cliente = FactoryGirl.create(:cliente, organizacion: org)
  informe = FactoryGirl.create(:informe, cliente: cliente)
end

Given(/^one new Informe was created yesterday$/) do
  y_informe = FactoryGirl.create(:informe, matricula: "Test yesterday", cliente: cliente, created_at: 1.day.ago )
end

When(/^another Informe from my Cliente is added$/) do
  internal_informe = FactoryGirl.create( :informe, matricula: "Nuevo informe interno",
    cliente: cliente )
end

When(/^I filter the Informes by the date of yesterday$/) do
  click_link "filtering"
  fill_in 'informes_range_from_3', with: 1.day.ago.strftime("%d/%m/%Y")
  fill_in 'informes_range_to_3', with: 1.day.ago.strftime("%d/%m/%Y")
  page.execute_script %Q{ $('#informes_range_from_3').trigger("focus") } # activate datetime picker
end

When(/^I submit not all the needed information for a new Informe$/) do
  visit new_online_informe_path
  click_button "Solicitar informe"
end

When(/^I submit all the information for a new Informe$/) do
  visit new_online_informe_path
  fill_in "Matricula", with: "AAA"
  fill_in "Solicitante", with: "Yo"
  select "Sinapse Consulting S.L.", from: "Cliente"
  click_button "Solicitar informe"
end

When(/^I access the edit page for a given Informe$/) do
  informe = Informe.last
  visit edit_online_informe_path(informe)
end

When(/^a new Informe is created during a (.*?)$/) do |weekday|
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
  elsif weekday == "Friday"
    some_day = "29-11-2013" # it was a Sunday
    on_week = 5 # wday for Sunday is 0
  end
  fecha = Date.parse( some_day ) 
  informe = FactoryGirl.create( :informe, created_at: fecha, cliente: Usuario.first.clientes.first )
  Informe.last.created_at.to_date.wday.should eql on_week
end

When(/^a new Informe is created a Friday at (\d+)\.(\d+)$/) do |hour, minute|
  guardia1 = FactoryGirl.create( :guardia )
  guardia2 = FactoryGirl.create( :guardia )
  a_friday = "31-01-2014"
  moment = DateTime.parse( a_friday ).change( { hour: hour.to_i, minute: minute.to_i } )
  informe = FactoryGirl.create( :informe, created_at: moment, cliente: Usuario.first.clientes.first )
  Informe.last.created_at.to_date.wday.should eql 5 #wday for Friday is 5
  Informe.last.created_at.to_time.hour.should eql hour.to_i
end

When(/^I am going to create a new Informe$/) do
  visit new_online_informe_path
end

Then(/^I should see a list of the Informes$/) do
  page.should have_title( I18n.t( "Informes de trafico" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  informes = usuario.informes
  informes.each do |informe|
    page.should have_selector( 'td', text: informe.matricula.upcase )
  end
  expect( page ).to have_selector( 'tr.informe', count: 2 )
end

Then(/^I should see a list of the Informes with matricula in uppercase$/) do
  page.should have_title( I18n.t( "Informes de trafico" ) )
  usuario = Usuario.find_by_nombre( "Angel" )
  informes = usuario.informes
  informes.each do |informe|
    page.should have_selector( 'td', text: informe.matricula.upcase )
  end
  expect( page ).to have_selector( 'tr.informe', count: 2 )
end

Then(/^the first Informe should be the most urgent one$/) do
  expect( first( 'tr.informe' ) ).to have_selector( 'td', text: "Otro informe".upcase )
end

Then(/^I should see just the list of the Informes from my Cliente$/) do
  expect( page ).to have_selector( 'tr.informe', count: 2 )
  expect( page ).to_not have_selector( 'td', text: "Informe externo" )
end

Then(/^I should (not )?see the list of all the Informes from my Organizacion$/) do |negation|
  rows = Informe.where(cliente_id: Organizacion.first.cliente_ids).count
  if negation
    expect( page ).to_not have_selector( 'tr.informe', count: rows )
  else
    expect( page ).to have_selector( 'tr.informe', count: rows )
  end
end

Then(/^I should see a list of all the Informes$/) do
  expect( page ).to have_selector( 'tr.informe', count: 1 )
end

Then(/^I should see the list of the Informes updated and sorted without reloading the page$/) do
  using_wait_time 20 do
    expect( page ).to have_selector( 'tr.informe', count: 3 )
    expect( first( '#informes tr.informe' ) ).to have_selector( 'td', text: "Nuevo informe interno".upcase)
  end
end

Then(/^I should see just the Informe created yesterday$/) do
  expect( page ).to have_selector( 'tr.informe', count: 1 )
end

Then(/^I should (not )?see a link to edit the Informes$/) do |negation|
  if negation
    rows = 0
  else
    rows = Informe.count
  end
  expect( page ).to have_selector( 'span.toedit', count: rows )
end

Then(/^a new Informe should (not )?be created$/) do |negation|
  if negation
    Informe.all.count.should eql( 0 )
  else
    Informe.all.count.should eql( 1 )
  end
end

Then(/^I should be able to edit the Informe$/) do
  page.should have_title( I18n.t( "Editar Informe Trafico" ) )
  page.should have_selector( "form.edit_informe" )
end

Then(/^I should see the newly created informe$/) do
  expect( page ).to have_selector( 'tr.informe', count: 1 )
  expect( first( '#informes tr.informe' ) ).to have_selector( 'td', text: "Test informe".upcase )
end

Then(/^the employees on guard would (not )?receive an email$/) do |negation|
  recipients = Guardia.pluck(:email)
  if negation
    inbox_emails = 0
  else
    inbox_emails = 1
  end
  recipients.each do |r|
    unread_emails_for(r).size.should == inbox_emails
  end
end

Then(/^I should see the current server Time as H:m$/) do
  page.should have_selector( "div#clock" )
end