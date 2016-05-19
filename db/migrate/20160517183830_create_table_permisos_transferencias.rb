class CreateTablePermisosTransferencias < ActiveRecord::Migration
  def change
  	create_table :clientes_perm_transferencias, id: false do |t|
	  t.integer :usuario_id
	  t.integer :cliente_id
	end
 	add_index :clientes_perm_transferencias, [:usuario_id, :cliente_id]
  end
end
