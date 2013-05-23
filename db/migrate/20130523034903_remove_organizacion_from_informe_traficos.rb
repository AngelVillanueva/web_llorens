class RemoveOrganizacionFromInformeTraficos < ActiveRecord::Migration
  def change
    remove_column :informe_traficos, :organizacion_id
  end
end
