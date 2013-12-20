class ChangeHasDocumentosDefaultToFalse < ActiveRecord::Migration
  def change
    change_column_default :expedientes, :has_documentos, false
  end
end
