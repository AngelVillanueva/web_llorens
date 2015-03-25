class AddRepresentanteToMandatos < ActiveRecord::Migration
  def change
  	add_column :mandatos, :repre_nombre, :string
  	add_column :mandatos, :repre_apellido_1, :string
  	add_column :mandatos, :repre_apellido_2, :string
  	add_column :mandatos, :nif_representante, :string
  end
end
