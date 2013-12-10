class ChangeHasDocumentosNullToFalse < ActiveRecord::Migration
  def change
    change_column_null :expedientes, :has_documentos, false, false
  end
end
