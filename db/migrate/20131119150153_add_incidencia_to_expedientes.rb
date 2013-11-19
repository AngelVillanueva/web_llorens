class AddIncidenciaToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :incidencia, :text
  end
end
