class ChangeDocumentosTableObservaciones < ActiveRecord::Migration
  def change
    add_column :documentos, :observaciones_cliente, :text
  end
end
