class CreateTableXmlVehicles < ActiveRecord::Migration
  def change
    create_table :xml_vehicles do |t|
      t.attachment :xml
      t.integer :cliente_id

      t.timestamps
    end
  end
end
