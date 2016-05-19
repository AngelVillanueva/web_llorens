class RenameTablePermisosInformes < ActiveRecord::Migration
  def change
    rename_table :clientes_permisos_informes, :clientes_perm_informes
  end 
end
