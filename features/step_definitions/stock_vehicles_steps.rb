When(/^I access the Remarketing page for the Cliente$/) do
  cliente = Cliente.last
  visit online_stock_vehicles_path( cliente )
end

Given(/^the Cliente I belong to has (\d+) Stock Vehicles$/) do |quantity|
  quantity.to_i.times do |n|
    FactoryGirl.create( :stock_vehicle, cliente: Cliente.first )
  end
end

Given(/^a Cliente I do not belong to has (\d+) Stock Vehicles$/) do |quantity|
  otra_organizacion = FactoryGirl.create( :organizacion )
  otro_cliente = FactoryGirl.create( :cliente, organizacion: otra_organizacion )
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