class AddCifToOrganizacions < ActiveRecord::Migration
  def change
    add_column :organizacions, :cif, :string
  end
end
