class CreateGuardias < ActiveRecord::Migration
  def change
    create_table :guardias do |t|
      t.string :email

      t.timestamps
    end
    add_index :guardias, :email
  end
end
