When(/^I create an Aviso in the admin panel$/) do
  visit rails_admin.dashboard_path
  # find( "li[data-model=cliente] a" ).click
  # first( '.new_collection_link a').click
  # fill_in "cliente_nombre", with: "potato"
  find( "li[data-model=aviso] a" ).click
  first( '.new_collection_link a').click
  fill_in "aviso_contenido", with: "potato"
end

Then(/^the Aviso should be created$/) do
  pending # do nothing
end