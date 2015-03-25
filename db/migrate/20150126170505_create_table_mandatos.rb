class CreateTableMandatos < ActiveRecord::Migration
  def change
    create_table :mandatos do |t|
      t.string :identificador
      t.string :nif_comprador
      t.string :nombre_razon_social
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :provincia
      t.string :municipio
      t.string :direccion
      t.string :matricula
      t.string :bastidor
      t.string :marca
      t.string :modelo
      t.string :pdf_file_name
      t.string :pdf_content_type
      t.integer :pdf_file_size
      t.date :pdf_updated_at
      t.datetime :hora_solicitud
      t.datetime :hora_entrega
      t.integer :cliente_id
      t.boolean :pending_pdf

      t.timestamps
    end
  end
end
