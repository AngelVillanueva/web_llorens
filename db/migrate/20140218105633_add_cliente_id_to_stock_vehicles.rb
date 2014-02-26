class AddClienteIdToStockVehicles < ActiveRecord::Migration
  def change
    add_column :stock_vehicles, :cliente_id, :integer
  end
end
