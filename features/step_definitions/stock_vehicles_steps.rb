When(/^I access the Remarketing page for the Cliente$/) do
  cliente = Cliente.first
  visit online_stock_vehicles_path( cliente )
end

Given(/^the Cliente I belong to has (\d+) Stock Vehicles$/) do |quantity|
  quantity.to_i.times do |n|
    FactoryGirl.create( :stock_vehicle, cliente: Cliente.first )
  end
end

Then(/^I should see a list of my (\d+) Stock Vehicles$/) do |quantity|
  expect( page ).to have_selector( 'tr.stock', count: quantity.to_i )
  if quantity.to_i > 0
    expect( page ).to have_selector( 'tr.stock td', text: "ABC1231")
  end
end