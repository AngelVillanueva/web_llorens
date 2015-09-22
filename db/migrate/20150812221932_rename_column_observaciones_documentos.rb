class RenameColumnObservacionesDocumentos < ActiveRecord::Migration
  def change
    rename_column :documentos, :obervaciones, :observaciones
  end
end
