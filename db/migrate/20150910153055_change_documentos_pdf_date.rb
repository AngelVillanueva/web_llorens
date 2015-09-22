class ChangeDocumentosPdfDate < ActiveRecord::Migration
  def change
	change_column :documentos, :pdf_updated_at, :datetime
	change_column :drivers, :pdf_updated_at, :datetime
  end
end
