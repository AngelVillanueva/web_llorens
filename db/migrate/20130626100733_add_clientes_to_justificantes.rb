class AddClientesToJustificantes < ActiveRecord::Migration
  def change
    add_column :justificantes, :cliente_id, :integer
  end
end
