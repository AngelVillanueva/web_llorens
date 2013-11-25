class RenameNotificaciones < ActiveRecord::Migration
  def change
    rename_table :notificaciones_pendientes, :notificaciones
  end
end
