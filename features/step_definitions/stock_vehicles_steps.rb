When(/^I access the Remarketing page for the Cliente$/) do
  cliente = Cliente.last
  visit online_cliente_stock_vehicles_path( cliente )
end

When(/^I access the page to create a new Stock Vehicle for the Cliente$/) do
  cliente = Cliente.last
  visit new_online_cliente_stock_vehicle_path( cliente )
end

When(/^I try to access the Remarketing page for the Cliente$/) do
  find( "a.remarketing").click
end

Given(/^the Cliente I belong to has (\d+) Stock Vehicles$/) do |quantity|
  mi_cliente = Cliente.first
  mi_cliente.has_remarketing = true
  mi_cliente.save!
  quantity.to_i.times do |n|
    FactoryGirl.create( :stock_vehicle, cliente: mi_cliente )
  end
end

Given(/^a Cliente I do not belong to has (\d+) Stock Vehicles$/) do |quantity|
  otra_organizacion = FactoryGirl.create( :organizacion )
  otro_cliente = FactoryGirl.create( :cliente, organizacion: otra_organizacion, has_remarketing: true )
  quantity.to_i.times do |n|
    FactoryGirl.create( :stock_vehicle, cliente: otro_cliente )
  end
end

Given(/^the first vehicle is not sold$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v1 = vehiculos.first
  v1.vendido?.should eql false
end

Given(/^the second vehicle is sold and with status of Documentacion Enviada$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v2 = vehiculos[1]
  v2.vendido = true
  v2.fecha_documentacion_enviada = Date.today
  v2.save!
end

Given(/^the last vehicle is sold and with status of Finalizado$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v3 = vehiculos.last
  v3.vendido = true
  v3.fecha_expediente_completo = 3.days.ago.to_date
  v3.fecha_documentacion_enviada = 2.days.ago.to_date
  v3.fecha_documentacion_recibida = Date.yesterday
  v3.fecha_envio_definitiva = Date.today
  v3.save!
end

Given(/^I have created a new Xml Vehicle file$/) do
  step "I upload a xml file containing one or more Stock Vehicles"
end

When(/^I upload a xml file containing one or more Stock Vehicles$/) do
  athlon = FactoryGirl.create(:cliente, llorens_cliente_id: "4300189329") # este es el codigo de cliente de athlon
  visit rails_admin.dashboard_path
  find( "li[data-model=xml_vehicle] a" ).click
  first( '.new_collection_link a').click
  attach_file "xml_vehicle_xml", "#{Rails.root}/spec/fixtures/my.xml"
  first( "button[type=submit]" ).click
end

When(/^I process the xml file$/) do
  find( "li.read_xml_member_link a").click
end

When(/^I submit the form with all the information for the new Stock Vehicle$/) do
  find( "li.read_xml_member_link a").click
end

When(/^I want to see the second Stock Vehicle data detail$/) do
  find( "td.icon:last-child a" ).click
end

Then(/^I should (not )?see a list of my (\d+) Stock Vehicles$/) do |negation, quantity|
  q = quantity.to_i
  unless negation
    expect( page ).to have_selector( 'tr.stock', count: q )
    (q-1).times do |t|
      matricula = StockVehicle.all[t].matricula
      expect( page ).to have_selector( 'tr.stock td', text: matricula)
    end
  else
    expect( page ).to_not have_selector( 'tr.stock', count: q )
    expect( page ).to have_selector( '.alert-alert', text: I18n.t( 'unauthorized.manage.all' ) )
  end
end

Then(/^I should see the first one as not sold$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v1 = vehiculos.first
  within( 'tr', text: v1.matricula ) do
    within( 'td.sold' ) do
      expect( text ).to eql( I18n.t("En venta") )
    end
    within( 'td.completed' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.sent' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.received' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.definitive' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.finished' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
  end
end

Then(/^I should see the second one as sold and with Documentacion Enviada$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v2 = vehiculos[1]
  within( 'tr', text: v2.matricula ) do
    within( 'td.sold' ) do
      expect( text ).to eql( I18n.t("Vendido") )
    end
    within( 'td.completed' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.sent' ) do
      expect( page ).to have_selector( 'i.done' )
    end
    within( 'td.received' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.definitive' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
    within( 'td.finished' ) do
      expect( page ).to have_selector( 'i.missing' )
    end
  end
end

Then(/^I should see the last one as sold and Finalizado$/) do
  vehiculos = StockVehicle.unscoped.order("created_at asc")
  v3 = vehiculos.last
  within( 'tr', text: v3.matricula ) do
    within( 'td.sold' ) do
      expect( text ).to eql( I18n.t("Vendido") )
    end
    within( 'td.completed' ) do
      expect( page ).to have_selector( 'i.done' )
    end
    within( 'td.sent' ) do
      expect( page ).to have_selector( 'i.done' )
    end
    within( 'td.received' ) do
      expect( page ).to have_selector( 'i.done' )
    end
    within( 'td.definitive' ) do
      expect( page ).to have_selector( 'i.done' )
    end
    within( 'td.finished' ) do
      expect( page ).to have_selector( 'i.done' )
    end
  end
end

Then(/^a new xml file with one or more Stock Vehicles should be created$/) do
  XmlVehicle.count.should eql 1
  Cliente.where(llorens_cliente_id: "4300189329").first.xml_vehicles.count.should eql 1
end

Then(/^the new Stock Vehicles should be created$/) do
  StockVehicle.count.should eql 2 # xml fixture file contains 2 StockVehicles
end

Then(/^assigned to the right Cliente$/) do
  Cliente.where(llorens_cliente_id: "4300189329").first.stock_vehicles.count.should eql 2
end

Then(/^the xml file should be marked as processed$/) do
  xml_file = XmlVehicle.last
  xml_file.processed.should eql true
end

Then(/^the user should be informed about the (\d+) new Stock Vehicles$/) do |quantity|
  q = quantity.to_i
  expect( page ).to have_selector( '.alert-success', text: "Encontrados y procesados correctamente el total de #{q}" )
end

Then(/^I should not see any link to access a Remarketing page$/) do
  expect( page ).to_not have_selector( 'ul.remarketing' )
  expect( page ).to_not have_selector( 'a.remarketing' )
end

Then(/^I should see all the attributes of the second Stock Vehicle$/) do
  matricula = StockVehicle.last.matricula
  expect( page ).to have_content( I18n.t "Detalle del vehiculo con matricula", matricula: matricula )
  expect( page ).to have_content( "#{I18n.t('Matricula')}: #{matricula}")
end