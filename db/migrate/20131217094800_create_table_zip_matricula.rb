class CreateTableZipMatricula < ActiveRecord::Migration
  def change
    create_table :zip_matriculas do |t|
      t.timestamps
    end
  end
end
