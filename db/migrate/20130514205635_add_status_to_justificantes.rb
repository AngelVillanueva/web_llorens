class AddStatusToJustificantes < ActiveRecord::Migration
  def change
    add_column :justificantes, :status, :boolean
  end
end
