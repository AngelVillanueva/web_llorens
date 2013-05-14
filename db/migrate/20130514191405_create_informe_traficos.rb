class CreateInformeTraficos < ActiveRecord::Migration
  def change
    create_table :informe_traficos do |t|
      t.string :matricula
      t.text :solicitante
      t.date :fecha_solicitud

      t.timestamps
    end
  end
end
