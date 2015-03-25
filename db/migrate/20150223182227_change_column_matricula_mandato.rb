class ChangeColumnMatriculaMandato < ActiveRecord::Migration
  def change
    add_column :mandatos, :matricula_bastidor, :text
    remove_column :mandatos, :matricula
    remove_column :mandatos, :bastidor
  end
end
