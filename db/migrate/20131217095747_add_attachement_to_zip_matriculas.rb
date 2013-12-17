class AddAttachementToZipMatriculas < ActiveRecord::Migration
  def change
    change_table :zip_matriculas do |t|
      t.attachment :zip
    end
  end
end
