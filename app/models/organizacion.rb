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
#  view_mandato  :boolean
#

class Organizacion < ActiveRecord::Base
  has_many :clientes
  has_many :usuarios
  before_destroy :check_for_usuarios

  validates :nombre, :identificador, presence: true

  rails_admin do
    edit do
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
      field :view_mandato do
        label I18n.t("Acceso a mandatos")
      end
    end
  end

  def expedientes
    Expediente.where(cliente_id: self.cliente_ids)
  end

  def check_for_usuarios
    if usuarios.count > 0
      errors.add :base, I18n.t("La organizacion tiene usuarios asociados")
      false
    end
  end
  
end