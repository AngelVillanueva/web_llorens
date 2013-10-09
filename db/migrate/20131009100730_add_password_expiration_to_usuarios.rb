class AddPasswordExpirationToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :password_changed_at, :datetime
    add_index :usuarios, :password_changed_at
  end
end
