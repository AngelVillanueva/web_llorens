class AddChecksMandatos < ActiveRecord::Migration
  def change
    add_column :mandatos, :imacompany, :boolean, default: false
    add_column :mandatos, :imanuevo, :boolean, default: false
    remove_column :mandatos, :sociedades
  end
end
