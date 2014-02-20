class AddMissingColumnsToStockVechicle < ActiveRecord::Migration
  def change
    add_column :stock_vehicles, :comprador, :string
    add_column :stock_vehicles, :ft, :boolean, default: false
    add_column :stock_vehicles, :pc, :boolean, default: false
    add_column :stock_vehicles, :fecha_itv, :date
    add_column :stock_vehicles, :incidencia, :text
    add_column :stock_vehicles, :fecha_expediente_completo, :date
    add_column :stock_vehicles, :fecha_documentacion_enviada, :date
    add_column :stock_vehicles, :fecha_documentacion_recibida, :date
    add_column :stock_vehicles, :fecha_notificado_cliente, :date
    add_column :stock_vehicles, :particular, :boolean, default: false
    add_column :stock_vehicles, :compra_venta, :boolean, default: false
    add_column :stock_vehicles, :fecha_envio_gestoria, :date
    add_column :stock_vehicles, :baja_exportacion, :boolean, default: true
    add_column :stock_vehicles, :fecha_entregado_david, :date
    add_column :stock_vehicles, :fecha_envio_definitiva, :date
    add_column :stock_vehicles, :observaciones, :text
  end
end
