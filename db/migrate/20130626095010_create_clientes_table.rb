class CreateClientesTable < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :identificador
      t.string :cif
    end
  end
end
