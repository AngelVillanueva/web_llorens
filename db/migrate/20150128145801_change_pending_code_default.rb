class ChangePendingCodeDefault < ActiveRecord::Migration
  def change
    change_column_default :mandatos, :pending_code, true
  end
end
