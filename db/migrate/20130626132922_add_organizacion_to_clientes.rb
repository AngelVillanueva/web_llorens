class AddOrganizacionToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :organizacion_id, :integer
  end
end
