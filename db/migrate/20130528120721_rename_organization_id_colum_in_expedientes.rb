class RenameOrganizationIdColumInExpedientes < ActiveRecord::Migration
  def change
    rename_column :expedientes, :organization_id, :organizacion_id
  end
end
