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
  has_many :justificantes
  has_many :informes
  has_many :stock_vehicles
  validates :nombre, :identificador, :cif, :llorens_cliente_id, :organizacion_id, presence: true

  rails_admin do
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
        field :expedientes
        field :justificantes
        field :informes
      end
      field :nombre
      field :identificador
      field :cif do
        label "CIF"
      end
      field :organizacion
      field :llorens_cliente_id do
        label I18n.t("llorens_cliente_id")
      end
    end
  end
end
