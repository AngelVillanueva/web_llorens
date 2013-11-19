class AddIndexByHasIncidenciaToExpedientes < ActiveRecord::Migration
  def change
    add_index :expedientes, :has_incidencia
  end
end
