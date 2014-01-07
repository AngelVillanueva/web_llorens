class AddTimestampsToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :created_at, :datetime
    add_column :avisos, :updated_at, :datetime
  end
end
