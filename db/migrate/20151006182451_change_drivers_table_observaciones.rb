class ChangeDriversTableObservaciones < ActiveRecord::Migration
  def change
    add_column :drivers, :observaciones, :text
    add_column :drivers, :observaciones_cliente, :text
  end
end
