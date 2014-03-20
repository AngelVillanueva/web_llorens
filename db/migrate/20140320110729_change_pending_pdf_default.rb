class ChangePendingPdfDefault < ActiveRecord::Migration
  def change
    change_column_default :justificantes, :pending_pdf, true
  end
end
