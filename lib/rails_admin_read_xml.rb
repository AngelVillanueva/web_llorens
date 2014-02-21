require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
require 'nokogiri'
 
module RailsAdminReadXml
end
 
module RailsAdmin
  module Config
    module Actions
      class ReadXml < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do
          true
        end
        register_instance_option :link_icon do
          'icon-cogs'
        end
        register_instance_option :bulkable? do
          false
        end
        register_instance_option :controller do
          Proc.new do
            # load xml file into 'content' variable
            total = 0
            content = Nokogiri::XML(File.open( object.xml.path ))
            # one row per Vehicle node
            rows = content.css("Vehicle")
            total = rows.count
            new_cars = 0
            # map each Vehicle with the data to be considered
            vehicles = rows.map do |node|
              node.css("licenseplate", "makename", "modelname").map {|n| n.text}.compact
            end.compact
            # create new Stock Vehicles for the non-existing ones
            vehicles.each do |v|
              unless a_car = StockVehicle.where(matricula: v[0].to_s).exists?
                a_car = StockVehicle.new
                a_car.matricula = v[0].to_s
                a_car.marca = v[1].to_s
                a_car.modelo = v[2].to_s
                a_car.cliente_id = object.cliente_id
                a_car.save!
                new_cars = new_cars + 1
              end
            end
            total == new_cars ? tipo = "success" : tipo = "alert"
            flash[tipo.to_sym] = create_message( total, new_cars )
            object.processed = true
            object.save!
            redirect_to back_or_index
          end
        end
      end
    end
  end
end

def create_message total, found
  if total == 0
    message = "No se han encontrado registros correctos"
  elsif found == 0
    message = "No se han encontrado registros nuevos"
  elsif total == found
    message = "Encontrados y procesados correctamente el total de #{total}."
  elsif total > found
    message = "Encontrados y procesados correctamente #{found} de #{total}, pero #{total-found} ya estaban creados o no eran correctos."
  end
end