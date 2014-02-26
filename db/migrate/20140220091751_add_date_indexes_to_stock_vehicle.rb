class AddDateIndexesToStockVehicle < ActiveRecord::Migration
  def change
    add_index :stock_vehicles, :fecha_expediente_completo
    add_index :stock_vehicles, :fecha_documentacion_enviada
    add_index :stock_vehicles, :fecha_documentacion_recibida
    add_index :stock_vehicles, :fecha_notificado_cliente
    add_index :stock_vehicles, :fecha_envio_gestoria
    add_index :stock_vehicles, :fecha_entregado_david
    add_index :stock_vehicles, :fecha_envio_definitiva
  end
end
