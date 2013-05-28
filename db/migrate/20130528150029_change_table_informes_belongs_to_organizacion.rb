class ChangeTableInformesBelongsToOrganizacion < ActiveRecord::Migration
  def change
    change_table :informes do |t|
      t.remove :usuario_id
      t.integer :organizacion_id
      t.index :organizacion_id
    end
  end
end
