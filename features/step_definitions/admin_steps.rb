Given(/^there is one Aviso created$/) do
  aviso = FactoryGirl.create( :aviso )
end

Given(/^there is another Aviso created$/) do
  aviso = FactoryGirl.create( :aviso, titular: "Another new aviso", contenido: "Texto del segundo aviso" )
end

Given(/^there is one Aviso created without titular$/) do
  aviso = FactoryGirl.create( :aviso, titular: nil )
end

Given(/^there is one Aviso created with an empty titular$/) do
  aviso = FactoryGirl.create( :aviso, titular: "" )
end

Given(/^there are two Avisos created$/) do
  aviso = FactoryGirl.create( :aviso )
  aviso2 = FactoryGirl.create( :aviso, titular: nil, contenido: "Texto del segundo aviso")
end

Given(/^its maximum date has expired$/) do
  aviso = Aviso.first
  aviso.fecha_de_caducidad = 1.day.ago
  aviso.save!
end

Given(/^its relative maximum date has been reached$/) do
  aviso = Aviso.first
  usuario = Usuario.first
  notificacion = Notificacion.where(aviso_id: aviso.id, usuario_id: usuario.id).first
  notificacion.caducidad_relativa = 1.day.ago
  notificacion.save!
end

Given(/^I am a registered User with no role$/) do
  user = FactoryGirl.create(:usuario)
  user.norole?
end

Given(/^the admin user has reordered them$/) do
  recent_aviso = Aviso.where(contenido: "Texto del segundo aviso").first
  old_aviso = Aviso.where(titular: "De: Quevedo" ).first
  old_aviso.sorting_order = 1
  old_aviso.save!
  recent_aviso.sorting_order = 2
  recent_aviso.save!
end

When(/^I access the admin panel$/) do
  visit root_path
  find( "li.administrator a" ).click
end

When(/^I create an Aviso in the admin panel$/) do
  visit rails_admin.dashboard_path
  find( "li[data-model=aviso] a" ).click
  first( '.new_collection_link a').click
  fill_in "aviso_titular", with: "Se hace saber"
  fill_in "aviso_contenido", with: "Importante aviso"
  first( "button[type=submit]" ).click
end

When(/^I visit the application home page and log in$/) do
  visit online_root_path
  fill_in "usuario_email", with: "info@sinapse.es"
  fill_in "usuario_password", with: "foobarfoo"
  first( "input[type=submit]" ).click
end

When(/^I visit the application home page per second time during the same session$/) do
  step "I visit the application home page"
  step "I should see the Aviso"
  visit download_path
  visit online_root_path
end

When(/^I create a new Aviso without sorting order$/) do
  my_aviso = FactoryGirl.create( :aviso, sorting_order: nil, titular: "Soy el penultimo Aviso creado" )
end

When(/^I create a new Aviso with the same sorting_order$/) do
  newer_aviso = FactoryGirl.create( :aviso, sorting_order: 1, titular: "Soy el ultimo creado" )
end

When(/^I create a new Aviso with the same sorting_order than a previous Aviso$/) do
  aviso_10 = FactoryGirl.create( :aviso, titular: "Debe ser el 11" )
  aviso_9 = FactoryGirl.create( :aviso, titular: "Debe ser el 10" )
  aviso_8 = FactoryGirl.create( :aviso, titular: "Debe ser el 9" )
  aviso_7 = FactoryGirl.create( :aviso, titular: "Debe ser el 8" )
  aviso_6 = FactoryGirl.create( :aviso, titular: "Debe ser el 7" )
  aviso_5 = FactoryGirl.create( :aviso, titular: "Debe ser el 6" )
  aviso_4 = FactoryGirl.create( :aviso, titular: "Debe ser el 5" )
  aviso_3 = FactoryGirl.create( :aviso, titular: "Debe ser el 4" )
  aviso_2 = FactoryGirl.create( :aviso, titular: "Debe ser el 3" )
  aviso_1 = FactoryGirl.create( :aviso, titular: "Debe ser el 1")
  new_aviso = FactoryGirl.create( :aviso, titular: "Debe ser el 2", sorting_order: 2)
end

When(/^I close the lightbox$/) do
  first( "button[data-dismiss=modal]" ).click
end

When(/^I close the Aviso warning$/) do
  first( ".barebones_aviso button.close" ).click
end

When(/^I check the Aviso status via session$/) do
  Aviso.count.should eql 1
  visit online_aviso_path( Aviso.first, format: :json )
  expect( page.body ).to have_content( "true" )
end

Then(/^the Aviso should be created$/) do
  Aviso.count.should eql 1
  Aviso.first.contenido.should eql "Importante aviso"
end

Then(/^I should (not )?see the Aviso$/) do |negation|
  if negation
    page.should_not have_selector( 'h3', text: Aviso.first.titular )
    page.should_not have_selector( '.modal-body', text: Aviso.first.contenido )
  else
    page.should have_selector( 'h3', text: Aviso.first.titular )
    page.should have_selector( '.modal-body', text: Aviso.first.contenido )
  end
end

Then(/^I should (not )?see the newly created Aviso$/) do |negation|
  using_wait_time 10 do
    if negation
      page.should_not have_selector( 'h4', text: Aviso.unscoped.first.titular )
      page.should_not have_selector( '.contenido', text: Aviso.unscoped.first.contenido )
    else
      page.should have_selector( 'h4', text: Aviso.unscoped.first.titular )
      page.should have_selector( '.contenido', text: Aviso.unscoped.first.contenido )
    end
  end
end

Then(/^I should (not )?see the latest created Aviso$/) do |negation|
  using_wait_time 10 do
    if negation
      page.should_not have_selector( 'h4', text: Aviso.unscoped.last.titular )
      page.should_not have_selector( '.contenido', text: Aviso.unscoped.last.contenido )
    else
      page.should have_selector( 'h4', text: Aviso.unscoped.last.titular )
      page.should have_selector( '.contenido', text: Aviso.unscoped.last.contenido )
    end
  end
end

Then(/^I should see the Aviso with "(.*?)" as the titular$/) do |text|
  page.should have_selector( 'h3', text: I18n.t( text ) )
  page.should have_selector( '.modal-body', text: Aviso.first.contenido )
end

Then(/^I should be able to close the Aviso$/) do
  first( "button[data-dismiss=modal]" ).click
  page.should_not have_selector( '.modal-body', text: Aviso.first.contenido )
end

Then(/^I should see the first Aviso$/) do
  page.should have_selector( 'h3', text: Aviso.first.titular )
  page.should have_selector( '.modal-body', text: Aviso.first.contenido ) 
end

Then(/^I should be able to see the second Aviso also$/) do
  first( "button[data-toggle=modal]" ).click
  page.should_not have_selector( '.modal-body', text: Aviso.first.contenido )
  page.should have_selector( 'h3', text: Aviso.last.titular )
  page.should have_selector( '.modal-body', text: Aviso.last.contenido )
end

Then(/^I should be able to see the second Aviso$/) do
  page.should have_selector( 'h3', text: I18n.t( "Aviso" ) )
  page.should have_selector( '.modal-body', text: Aviso.last.contenido )
end

Then(/^the Aviso should be deleted$/) do 
  current_usuario = Usuario.first
  current_usuario.avisos.caducados.count.should eql 0
end

Then(/^I should see the Avisos in the admin user defined order$/) do
  Aviso.count.should eql 2
  Aviso.first.sorting_order.should eql 1
  Aviso.last.sorting_order.should eql 2
end

Then(/^the previous Aviso should change its sorting_order by (\d+)$/) do |arg1|
  Aviso.where(titular: "Debe ser el 3").first.sorting_order.should eql 3
end

Then(/^all the following Avisos should also change its sorting_order by (\d+)$/) do |arg1|
  Aviso.where(titular: "Debe ser el 4").first.sorting_order.should eql 4
end

Then(/^the non affected Avisos should not change its sorting_order$/) do
  Aviso.where(titular: "Debe ser el 1").first.sorting_order.should eql 1
end

Then(/^I should (not )?see the Matriculaciones menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=matriculacion] a" )
  else
    page.should have_css( "li[data-model=matriculacion] a" )
  end
end

Then(/^I should (not )?see the Justificantes menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=justificante] a" )
  else
    page.should have_css( "li[data-model=justificante] a" )
  end
end

Then(/^I should (not )?see the Mandatos menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=mandato] a" )
  else
    page.should have_css( "li[data-model=mandato] a" )
  end
end

Then(/^I should (not )?see the Informes menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=informe] a" )
  else
    page.should have_css( "li[data-model=informe] a" )
  end
end

Then(/^I should (not )?see the ZipMatriculas menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=zip_matricula] a" )
  else
    page.should have_css( "li[data-model=zip_matricula] a" )
  end
end

Then(/^I should (not )?see the Configuration menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=configuration] a" )
  else
    page.should have_css( "li[data-model=configuration] a" )
  end
end

Then(/^I should (not )?see the StockVehicles menu link$/) do |negation|
  if negation
    page.should_not have_css( "li[data-model=stock_vehicle] a" )
  else
    page.should have_css( "li[data-model=stock_vehicle] a" )
  end
end


Then(/^the first Aviso to appear should be the latest Aviso created$/) do
  visit online_root_path
  my_aviso = Aviso.where(titular: "Soy el ultimo creado").first
  page.should have_selector( 'h3', text: my_aviso.titular )
  page.should have_selector( '.modal-body', text: my_aviso.contenido )
  visit rails_admin.dashboard_path
  find( "li[data-model=aviso] a" ).click
  cell = first("tr td.titular_field")
  expect( cell ).to have_content( my_aviso.titular )
end
Then(/^if I stay in the same page I should not see the newly created Aviso twice$/) do
  using_wait_time 10 do
    expect( page ).to have_selector( ".contenido", maximum: 1 )
  end
end
Then(/^if I stay in the same page$/) do
  using_wait_time 10 do
  end
end
Then(/^I should not see the newly created Aviso twice$/) do
  using_wait_time 10 do
    expect( page ).to have_selector( ".contenido", count: Aviso.count )
  end
end
Then(/^it should have a data attribute to pull new Avisos$/) do
  expect( page ).to have_css( ".about_page[data-pulltime]")
end
Then(/^I should (not )?see the Aviso previously shown in the lightbox$/) do |negation|
  if negation
    expect( page ).to_not have_css( ".barebones_aviso .alert .contenido", text: Aviso.unscoped.first.contenido )
  else
    expect( page ).to have_css( ".barebones_aviso .alert .contenido", text: Aviso.unscoped.first.contenido )
  end
end

Then(/^if I do not close the Aviso$/) do
  expect( page ).to have_selector( "#av#{Aviso.unscoped.last.id}" )
end

Then(/^the page is auto reloaded$/) do
  visit online_justificantes_path
end