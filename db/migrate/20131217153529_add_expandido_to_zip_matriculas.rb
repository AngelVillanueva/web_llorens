class AddExpandidoToZipMatriculas < ActiveRecord::Migration
  def change
    add_column :zip_matriculas, :expandido, :boolean, default: false
  end
end
