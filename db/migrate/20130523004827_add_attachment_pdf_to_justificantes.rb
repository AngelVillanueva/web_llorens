class AddAttachmentPdfToJustificantes < ActiveRecord::Migration
  def self.up
    change_table :justificantes do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :justificantes, :pdf
  end
end
