class AddSolicitanteToInformes < ActiveRecord::Migration
  def change
    add_column :informes, :solicitante, :string
  end
end
