class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :justificantes, :usuario_id
    add_index :expedientes, :organizacion_id
    add_index :usuarios, :organizacion_id
  end
end
