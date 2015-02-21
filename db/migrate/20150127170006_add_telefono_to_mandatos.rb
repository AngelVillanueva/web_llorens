class AddTelefonoToMandatos < ActiveRecord::Migration
  def change
  	add_column :mandatos, :telefono, :integer
  end
end
