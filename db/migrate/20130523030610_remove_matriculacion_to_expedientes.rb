class RemoveMatriculacionToExpedientes < ActiveRecord::Migration
  def change
    remove_column :expedientes, :matriculacion
  end
end
