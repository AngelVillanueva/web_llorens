class ChangeSociedadesDefaultMandatos < ActiveRecord::Migration
  def change
    change_column_default :mandatos, :sociedades, false
  end
end
