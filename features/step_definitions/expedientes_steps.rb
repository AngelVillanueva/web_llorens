Then(/^I should see a list of the Expedientes$/) do
  page.should have_title("Listado de Expedientes")
  expedientes = Expediente.all.each do |expediente|
    page.should have_selector("td", text: expediente.identificador)
  end
end