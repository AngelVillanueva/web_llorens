class AddPendingPdfToJustificantes < ActiveRecord::Migration
  def change
    add_column :justificantes, :pending_pdf, :boolean, default: false
  end
end
