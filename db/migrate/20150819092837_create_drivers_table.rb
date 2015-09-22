class CreateDriversTable < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :matricula
      t.string :bastidor
      t.date :fecha_matriculacion
      t.boolean :envio_ok
      t.date :fecha_envio
      t.boolean :concesionario_cliente
      t.string :direccion
      t.string :persona_contacto
      t.string :pdf_file_name
      t.string :pdf_content_type
      t.integer :pdf_file_size
      t.date :pdf_updated_at
      t.timestamps
    end
  end
end
