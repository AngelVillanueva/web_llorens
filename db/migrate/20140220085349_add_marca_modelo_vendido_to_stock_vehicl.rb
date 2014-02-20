class AddMarcaModeloVendidoToStockVehicl < ActiveRecord::Migration
  def change
    add_column :stock_vehicles, :marca, :string
    add_column :stock_vehicles, :modelo, :string
    add_column :stock_vehicles, :vendido, :boolean, default: false
  end
end
