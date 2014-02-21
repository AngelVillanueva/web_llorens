class AddHasRemarketingToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :has_remarketing, :boolean, default: false
    add_index :clientes, :has_remarketing
  end
end
