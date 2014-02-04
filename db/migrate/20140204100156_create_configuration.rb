class CreateConfiguration < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :option
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
