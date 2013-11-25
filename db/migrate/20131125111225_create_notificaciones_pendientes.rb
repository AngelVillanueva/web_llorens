class CreateNotificacionesPendientes < ActiveRecord::Migration
  def change
    create_table :notificaciones_pendientes do |t|
      t.integer :aviso_id
      t.integer :usuario_id

      t.timestamps
    end
    add_index :notificaciones_pendientes, :aviso_id
    add_index :notificaciones_pendientes, :usuario_id
  end
end
