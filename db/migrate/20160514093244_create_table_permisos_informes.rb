class CreateTablePermisosInformes < ActiveRecord::Migration
  def change
  	create_table :clientes_permisos_informes, id: false do |t|
	  t.integer :usuario_id
	  t.integer :cliente_id
	end
 	add_index :clientes_permisos_informes, [:usuario_id, :cliente_id]
  end
end
