# == Schema Information
#
# Table name: clientes
#
#  id            :integer          not null, primary key
#  nombre        :string(255)
#  identificador :string(255)
#  cif           :string(255)
#

class Cliente < ActiveRecord::Base
  validates :nombre, :identificador, :cif, presence: true
end
