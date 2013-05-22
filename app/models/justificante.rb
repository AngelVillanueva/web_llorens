# == Schema Information
#
# Table name: justificantes
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
#  fecha_sale_trafico  :date
#  dias_tramite        :integer
#  matriculacion       :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  status              :boolean
#

class Justificante < ActiveRecord::Base
  attr_accessible :status, :bastidor, :comprador, :dias_tramite, :fecha_alta, :fecha_entra_trafico, :fecha_sale_trafico, :identificador, :marca, :matricula, :matriculacion, :modelo, :vendedor
end
