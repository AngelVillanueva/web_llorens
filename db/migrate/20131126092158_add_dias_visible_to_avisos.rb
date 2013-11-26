class AddDiasVisibleToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :dias_visible_desde_ultimo_login, :integer
  end
end
