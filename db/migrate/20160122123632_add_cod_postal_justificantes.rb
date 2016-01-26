class AddCodPostalJustificantes < ActiveRecord::Migration
  def change
  	add_column :justificantes, :codpostal, :string
  end
end
