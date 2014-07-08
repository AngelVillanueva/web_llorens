class CreateIvtmColumnWithScale < ActiveRecord::Migration
  def change
    add_column :expedientes, :ivtm, :decimal, :precision => 15, :scale => 2
  end
end
