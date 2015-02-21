class RemoveClienteMandatos < ActiveRecord::Migration
  def change
    remove_column :mandatos, :cliente_id
  end
end
