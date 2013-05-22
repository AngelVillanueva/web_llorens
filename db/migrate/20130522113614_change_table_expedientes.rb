class ChangeTableExpedientes < ActiveRecord::Migration
  def change
    remove_column :expedientes, :dias_tramite
    add_column :expedientes, :observaciones, :text
    rename_column :expedientes, :fecha_sale_trafico, :fecha_facturacion
  end
end
