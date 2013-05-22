class CreateJustificantes < ActiveRecord::Migration
  def change
    create_table :justificantes do |t|
      t.string :identificador
      t.string :nif_comprador
      t.string :nombre_razon_social
      t.string :primer_apellido
      t.string :segundo_apellido
      t.string :provincia
      t.string :municipio
      t.text :direccion
      t.string :matricula
      t.string :bastidor
      t.string :marca
      t.string :modelo
      t.integer :usuario_id

      t.timestamps
    end
  end
end
