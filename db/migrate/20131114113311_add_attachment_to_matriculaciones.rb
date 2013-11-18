class AddAttachmentToMatriculaciones < ActiveRecord::Migration
  def self.up
    change_table :expedientes do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :expedientes, :pdf
  end
end
