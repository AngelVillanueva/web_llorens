class AddClientesToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :cliente_id, :integer
  end
end
