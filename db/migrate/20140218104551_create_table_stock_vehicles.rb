class CreateTableStockVehicles < ActiveRecord::Migration
  def change
    create_table :stock_vehicles do |t|
      t.string :matricula

      t.timestamps
    end
  end
end
