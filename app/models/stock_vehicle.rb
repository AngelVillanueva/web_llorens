# == Schema Information
#
# Table name: stock_vehicles
#
#  id         :integer          not null, primary key
#  matricula  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cliente_id :integer
#

class StockVehicle < ActiveRecord::Base
  belongs_to :cliente
  validates :matricula, presence: true, uniqueness: true

  def expediente_completo?
    !fecha_expediente_completo.nil?
  end
  def documentacion_enviada?
    !fecha_documentacion_enviada.nil?
  end
  def documentacion_recibida?
    !fecha_documentacion_recibida.nil?
  end
  def envio_documentacion_definitiva?
    !fecha_envio_definitiva.nil?
  end
  def finalizado?
    expediente_completo? && documentacion_enviada? && documentacion_recibida? && envio_documentacion_definitiva?
  end
end
