class AddFieldsToTableOfUsuarios < ActiveRecord::Migration
  def change
    change_table :usuarios do |t|
      t.string :nombre
      t.string :apellidos
      t.string :organizacion
      t.string :identificador_organizacion
      t.index :identificador_organizacion
    end
  end
end
