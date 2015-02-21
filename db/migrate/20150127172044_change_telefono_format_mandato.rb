class ChangeTelefonoFormatMandato < ActiveRecord::Migration
  def up
  	change_column :mandatos, :telefono, :string
  end

  def down
  	change_column :mandatos, :telefono, :integer
  end
end
