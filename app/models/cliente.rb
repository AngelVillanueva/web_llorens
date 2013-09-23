# == Schema Information
#
# Table name: clientes
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)
#  identificador      :string(255)
#  cif                :string(255)
#  organizacion_id    :integer
#  llorens_cliente_id :string(255)
#

class Cliente < ActiveRecord::Base
  belongs_to :organizacion
  has_many :expedientes
  validates :nombre, :identificador, :cif, :llorens_cliente_id, :organizacion_id, presence: true
end
