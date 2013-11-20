class CreateAvisos < ActiveRecord::Migration
  def change
    create_table :avisos do |t|
      t.text :contenido
    end
  end
end
