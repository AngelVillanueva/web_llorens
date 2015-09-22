class ChangeDocumentosFields < ActiveRecord::Migration
  def change
  	rename_column :documentos, :pending_pdf, :upload_pdf
    remove_column :documentos, :fecha_carga
  end
end
