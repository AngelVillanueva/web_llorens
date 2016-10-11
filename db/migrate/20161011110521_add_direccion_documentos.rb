class AddDireccionDocumentos < ActiveRecord::Migration
  def change
  	add_column :documentos, :direccion, :string
  end
end
