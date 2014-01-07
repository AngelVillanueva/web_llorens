class AddSortingToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :sorting_order, :integer
    add_index :avisos, :sorting_order
  end
end
