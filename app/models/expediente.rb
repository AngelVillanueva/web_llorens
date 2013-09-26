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
#  type                :string(255)
#  cliente_id          :integer
#  llorens_cliente_id  :string(255)
#

class Expediente < ActiveRecord::Base
  belongs_to :cliente
  default_scope includes(:cliente).order('created_at DESC')

  #before_validation :assign_internal_cliente_id

  validates :identificador, :matricula, :bastidor, :comprador, :marca, :modelo, :fecha_alta, :cliente_id, :type, presence: true

  def fecha_sale_trafico
    fecha_facturacion
  end

  def dias_tramite
    return nil if ( fecha_sale_trafico.nil? && fecha_alta.nil? )
    ( fecha_sale_trafico - fecha_alta ).to_i
  end

  # def assign_internal_cliente_id
  #   internal_cliente = Cliente.where(llorens_cliente_id: self.cliente_id.to_s).first
  #   self.cliente_id = internal_cliente.id 
  # end
end
