class ChangeTableUsuarios < ActiveRecord::Migration
  def change
    change_table :usuarios do |t|
      t.remove :organizacion
      t.remove :identificador_organizacion
    end
  end
end
