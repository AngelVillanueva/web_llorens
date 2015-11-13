class ChangeDocumentosDefaultFields < ActiveRecord::Migration
  def change
    change_column_default :documentos, :download_pdf, false
    change_column_default :documentos, :upload_pdf, false
  end
end
