class AddHasDocumentosToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :has_documentos, :boolean
  end
end
