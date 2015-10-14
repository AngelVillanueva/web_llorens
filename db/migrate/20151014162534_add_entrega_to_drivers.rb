class AddEntregaToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :entrega, :boolean, default: false
  end
end
