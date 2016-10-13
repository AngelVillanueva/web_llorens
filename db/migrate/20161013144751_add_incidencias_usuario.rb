class AddIncidenciasUsuario < ActiveRecord::Migration
 def change
    add_column :usuarios, :incidencias, :boolean, default: false
  end
end
