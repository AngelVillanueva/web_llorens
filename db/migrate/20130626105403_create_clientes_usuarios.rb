class CreateClientesUsuarios < ActiveRecord::Migration
  create_table :clientes_usuarios, :id => false do |t|
    t.integer :cliente_id
    t.integer :usuario_id
  end
end
