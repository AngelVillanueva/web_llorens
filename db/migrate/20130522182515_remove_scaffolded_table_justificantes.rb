class RemoveScaffoldedTableJustificantes < ActiveRecord::Migration
  def change
    drop_table :justificantes
  end
end
