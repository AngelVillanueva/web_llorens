class RemoveOrganizacionColumns < ActiveRecord::Migration
  def change
    remove_column :expedientes, :organizacion_id
    remove_column :justificantes, :organizacion_id
    remove_column :informes, :organizacion_id

    add_index :expedientes, :cliente_id
    add_index :justificantes, :cliente_id
    add_index :informes, :cliente_id
  end
end
