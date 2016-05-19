class AddCheckPermisosUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :check_permisos, :boolean, default: false
  end
end
