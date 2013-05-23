class ChangeTableInformeTraficosFechaIdentificador < ActiveRecord::Migration
  def change
    remove_column :informe_traficos, :fecha_solicitud
    add_column :informe_traficos, :identificador, :string
  end
end
