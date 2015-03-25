class ChangeColumnMatriculaTypeMandato < ActiveRecord::Migration
   def up
  	change_column :mandatos, :matricula_bastidor, :string
  end

  def down
  	change_column :mandatos, :matricula_bastidor, :text
  end
end
