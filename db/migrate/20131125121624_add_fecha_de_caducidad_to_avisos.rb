class AddFechaDeCaducidadToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :fecha_de_caducidad, :date
  end
end
