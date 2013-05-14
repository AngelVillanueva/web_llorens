class AddStatusToInformeTraficos < ActiveRecord::Migration
  def change
    add_column :informe_traficos, :status, :boolean
  end
end
