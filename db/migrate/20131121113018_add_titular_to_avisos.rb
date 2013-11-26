class AddTitularToAvisos < ActiveRecord::Migration
  def change
    add_column :avisos, :titular, :string
  end
end
