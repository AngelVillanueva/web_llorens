class ChangeBajaExportacionDefault < ActiveRecord::Migration
  def change
    change_column_default :stock_vehicles, :baja_exportacion, false
  end
end
