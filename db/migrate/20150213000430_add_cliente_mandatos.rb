class AddClienteMandatos < ActiveRecord::Migration
  def change
    add_column :mandatos, :cliente_id, :integer
  end
end
