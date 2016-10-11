class AddClientToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :cliente_id, :integer
  end
end
