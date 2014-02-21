# == Schema Information
#
# Table name: stock_vehicles
#
#  id                           :integer          not null, primary key
#  matricula                    :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  cliente_id                   :integer
#  marca                        :string(255)
#  modelo                       :string(255)
#  vendido                      :boolean          default(FALSE)
#  comprador                    :string(255)
#  ft                           :boolean          default(FALSE)
#  pc                           :boolean          default(FALSE)
#  fecha_itv                    :date
#  incidencia                   :text
#  fecha_expediente_completo    :date
#  fecha_documentacion_enviada  :date
#  fecha_documentacion_recibida :date
#  fecha_notificado_cliente     :date
#  particular                   :boolean          default(FALSE)
#  compra_venta                 :boolean          default(FALSE)
#  fecha_envio_gestoria         :date
#  baja_exportacion             :boolean          default(TRUE)
#  fecha_entregado_david        :date
#  fecha_envio_definitiva       :date
#  observaciones                :text
#

class StockVehicle < ActiveRecord::Base
  belongs_to :cliente
  validates :matricula, presence: true, uniqueness: true
  default_scope order('vendido ASC')
  paginates_per 10

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

  rails_admin do
    navigation_label I18n.t( "REMARKETING")
    label I18n.t( "Stock Vehicles")
  end
end
