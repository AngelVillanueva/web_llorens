class AddProcessedToXmlVehicles < ActiveRecord::Migration
  def change
    add_column :xml_vehicles, :processed, :boolean, default: false
  end
end
