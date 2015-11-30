class AddContratoToDocDrivers < ActiveRecord::Migration
   def change
  	add_column :documentos, :contrato, :string
  	add_column :drivers, :contrato, :string
  end
end
