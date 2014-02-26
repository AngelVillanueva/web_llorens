class AddUniqueIndexToStockVehicle < ActiveRecord::Migration
  def change
    add_index :stock_vehicles, :matricula, unique: true
  end
end
