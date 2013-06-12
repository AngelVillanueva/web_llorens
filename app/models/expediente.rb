# == Schema Information
#
# Table name: expedientes
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  matricula           :string(255)
#  bastidor            :string(255)
#  comprador           :text
#  vendedor            :text
#  marca               :string(255)
#  modelo              :string(255)
#  fecha_alta          :date
#  fecha_entra_trafico :date
#  fecha_facturacion   :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  observaciones       :text
#  organizacion_id     :integer
#  type                :string(255)
#

class Expediente < ActiveRecord::Base
  belongs_to :organizacion
  default_scope order('created_at DESC')

  validates :identificador, :matricula, :bastidor, :comprador, :vendedor, :marca, :modelo, :fecha_alta, :fecha_entra_trafico, :fecha_facturacion, :organizacion_id, :type, presence: true

  def fecha_sale_trafico
    fecha_facturacion
  end

  def dias_tramite
    return nil if ( fecha_sale_trafico.nil? && fecha_alta.nil? )
    ( fecha_sale_trafico - fecha_alta ).to_i
  end
end
