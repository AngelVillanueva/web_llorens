# == Schema Information
#
# Table name: clientes
#
#  id              :integer          not null, primary key
#  nombre          :string(255)
#  identificador   :string(255)
#  cif             :string(255)
#  organizacion_id :integer
#

class Cliente < ActiveRecord::Base
  belongs_to :organizacion
  validates :nombre, :identificador, :cif, presence: true
end
