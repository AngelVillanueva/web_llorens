class ChangeTableInformeTraficos < ActiveRecord::Migration
  def change
    change_table :informe_traficos do |t|
      t.remove :solicitante
      t.remove :status
      t.integer :organizacion_id
      t.integer :usuario_id
      t.index :organizacion_id
      t.index :usuario_id
    end
  end
end
