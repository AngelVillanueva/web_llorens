class AddResolucionToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :fecha_resolucion_incidencia, :date
  end
end
