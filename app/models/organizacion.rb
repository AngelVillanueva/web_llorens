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

  validates :nombre, :identificador, presence: true

  rails_admin do
    group :advanced do
      label I18n.t("Advanced")
      active false
    end
    field :nombre
    field :identificador
    field :cif do
      label "CIF"
      group :advanced
    end
    field :usuarios do
      group :advanced
    end
    field :clientes do
      group :advanced
    end
  end
  
end
