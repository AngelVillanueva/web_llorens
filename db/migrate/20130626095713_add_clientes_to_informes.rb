class AddClientesToInformes < ActiveRecord::Migration
  def change
    add_column :informes, :cliente_id, :integer
  end
end
