class AddSecureTokenToMandato < ActiveRecord::Migration
  def change
  	add_column :mandatos, :secure_token, :string
  end
end
