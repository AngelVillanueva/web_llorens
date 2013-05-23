# == Schema Information
#
# Table name: justificantes
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  nif_comprador       :string(255)
#  nombre_razon_social :string(255)
#  primer_apellido     :string(255)
#  segundo_apellido    :string(255)
#  provincia           :string(255)
#  municipio           :string(255)
#  direccion           :text
#  matricula           :string(255)
#  bastidor            :string(255)
#  marca               :string(255)
#  modelo              :string(255)
#  usuario_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#

class Justificante < ActiveRecord::Base
  belongs_to :usuario
  has_attached_file :pdf

  validates :nif_comprador, :usuario_id, presence: true
end
