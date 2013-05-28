# == Schema Information
#
# Table name: organizacions
#
#  id            :integer          not null, primary key
#  nombre        :string(255)
#  identificador :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Organizacion < ActiveRecord::Base
  has_many :usuarios
  has_many :expedientes
  has_many :justificantes
  has_many :informes
  
end
