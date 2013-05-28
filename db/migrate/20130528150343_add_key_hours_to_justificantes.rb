class AddKeyHoursToJustificantes < ActiveRecord::Migration
  def change
    add_column :justificantes, :hora_solicitud, :datetime
    add_column :justificantes, :hora_entrega, :datetime
  end
end
