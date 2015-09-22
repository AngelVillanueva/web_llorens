class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.string :bastidor
      t.boolean :ficha_tecnica
      t.string :concesionario
      t.date :fecha_recepcion
      t.string :pdf_file_name
      t.string :pdf_content_type
      t.integer :pdf_file_size
      t.date :pdf_updated_at
      t.integer :dias_tramite
      t.boolean :pending_pdf
      t.boolean :download_pdf
      t.text :obervaciones
      t.timestamps
    end
  end
end
