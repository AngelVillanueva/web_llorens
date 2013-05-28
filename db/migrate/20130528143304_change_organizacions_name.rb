class ChangeOrganizacionsName < ActiveRecord::Migration
  def change
    rename_table :organizacions, :organizaciones
  end
end
