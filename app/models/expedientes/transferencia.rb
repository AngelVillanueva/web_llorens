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

class Transferencia < Expediente
  validates :vendedor, presence: true
end
