class AddTypeMandatos < ActiveRecord::Migration
  def change
    add_column :mandatos, :sociedades, :boolean
  end
end
