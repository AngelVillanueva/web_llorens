class AddTypeToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :type, :string
  end
end
