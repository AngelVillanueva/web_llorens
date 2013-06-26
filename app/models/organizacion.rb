# == Schema Information
#
# Table name: organizaciones
#
#  id            :integer          not null, primary key
#  nombre        :string(255)
#  identificador :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cif           :string(255)
#

class Organizacion < ActiveRecord::Base
  has_many :clientes
  has_many :usuarios

  validates :nombre, :identificador, :cif, presence: true
  
end
