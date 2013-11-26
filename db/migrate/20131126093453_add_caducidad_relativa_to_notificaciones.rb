class AddCaducidadRelativaToNotificaciones < ActiveRecord::Migration
  def change
    add_column :notificaciones, :caducidad_relativa, :date
  end
end
