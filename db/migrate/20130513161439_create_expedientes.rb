class CreateExpedientes < ActiveRecord::Migration
  def change
    create_table :expedientes do |t|
      t.string :identificador
      t.string :matricula
      t.string :bastidor
      t.text :comprador
      t.text :vendedor
      t.string :marca
      t.string :modelo
      t.date :fecha_alta
      t.date :fecha_entra_trafico
      t.date :fecha_sale_trafico
      t.integer :dias_tramite
      t.boolean :matriculacion

      t.timestamps
    end
  end
end
