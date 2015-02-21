class ChangeTableMandatosPdfPending < ActiveRecord::Migration
  def change
    remove_column :mandatos, :pending_pdf
    add_column :mandatos, :pending_code, :boolean
  end
end
