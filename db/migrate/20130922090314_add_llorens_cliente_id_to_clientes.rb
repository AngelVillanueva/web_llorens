class AddLlorensClienteIdToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :llorens_cliente_id, :string

    add_index :expedientes, :llorens_cliente_id
    add_index :clientes, :llorens_cliente_id
  end
end
