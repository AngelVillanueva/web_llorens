class AddLlorensClienteIdFieldToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :llorens_cliente_id, :string
  end
end
