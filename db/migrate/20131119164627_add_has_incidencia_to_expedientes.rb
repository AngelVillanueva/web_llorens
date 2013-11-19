class AddHasIncidenciaToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :has_incidencia, :boolean
  end
end
