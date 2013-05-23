class AddOrganizationToExpedientes < ActiveRecord::Migration
  def change
    add_column :expedientes, :organization_id, :integer
  end
end
