class RemoveIvtmColumn < ActiveRecord::Migration
  def change
    remove_column :expedientes, :ivtm
  end
end
