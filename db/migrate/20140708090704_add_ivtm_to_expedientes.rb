class AddIvtmToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :ivtm, :decimal
  end
end
