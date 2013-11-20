When(/^I create an Aviso in the admin panel$/) do
  visit rails_admin.dashboard_path
  # find( "li[data-model=cliente] a" ).click
  # first( '.new_collection_link a').click
  # fill_in "cliente_nombre", with: "potato"
  find( "li[data-model=aviso] a" ).click
  first( '.new_collection_link a').click
  fill_in "aviso_contenido", with: "Importante aviso"
  first( "button[type=submit]" ).click
end

Then(/^the Aviso should be created$/) do
  Aviso.count.should eql 1
  Aviso.first.contenido.should eql "Importante aviso"
end