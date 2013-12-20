Given(/^there is one Aviso created$/) do
  aviso = FactoryGirl.create( :aviso )
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
  recent_aviso = Aviso.unscoped.order("created_at desc").last
  old_aviso = Aviso.unscoped.order("created_at desc").first
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
  page.should have_selector( 'h3', text: I18n.t( "Aviso" ) )
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

Then(/^I should see the Matriculaciones menu link$/) do
  page.should have_css( "li[data-model=matriculacion] a" )
end

Then(/^I should see the Justificantes menu link$/) do
  page.should have_css( "li[data-model=justificante] a" )
end

Then(/^I should see the Informes menu link$/) do
  page.should have_css( "li[data-model=informe] a" )
end