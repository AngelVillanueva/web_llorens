class ChangeInformeTraficosName < ActiveRecord::Migration
  def change
    rename_table :informe_traficos, :informes_trafico
  end
end
