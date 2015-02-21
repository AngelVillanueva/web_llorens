class ChangeDireccionFormatMandato < ActiveRecord::Migration
  def up
  	change_column :mandatos, :direccion, :text
  end

  def down
  	change_column :mandatos, :direccion, :string
  end
end
