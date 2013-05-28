class AddMissingIndexesTwo < ActiveRecord::Migration
  def change
    add_index :expedientes, [:id, :type]
  end
end
