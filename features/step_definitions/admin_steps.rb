Given(/^there is one Aviso created$/) do
  aviso = FactoryGirl.create( :aviso )
end

When(/^I create an Aviso in the admin panel$/) do
  visit rails_admin.dashboard_path
  find( "li[data-model=aviso] a" ).click
  first( '.new_collection_link a').click
  fill_in "aviso_contenido", with: "Importante aviso"
  first( "button[type=submit]" ).click
end

Then(/^the Aviso should be created$/) do
  Aviso.count.should eql 1
  Aviso.first.contenido.should eql "Importante aviso"
end

Then(/^I should see the Aviso$/) do
  page.should have_content( Aviso.first.contenido )
end