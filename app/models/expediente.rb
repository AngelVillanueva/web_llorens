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
#  matriculacion       :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  observaciones       :text
#

class Expediente < ActiveRecord::Base
  belongs_to :organizacion

  def fecha_sale_trafico
    fecha_facturacion
  end

  def dias_tramite
    return nil if ( fecha_sale_trafico.nil? && fecha_alta.nil? )
    ( fecha_sale_trafico - fecha_alta ).to_i
  end
end
