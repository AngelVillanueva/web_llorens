class ChangeInformeTraficosNameAgain < ActiveRecord::Migration
  def change
    rename_table :informes_trafico, :informes
  end
end
