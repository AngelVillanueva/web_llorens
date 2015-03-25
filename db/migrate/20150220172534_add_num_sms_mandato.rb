class AddNumSmsMandato < ActiveRecord::Migration
  def change
    add_column :mandatos, :count_sms, :integer, default: 0
  end
end
