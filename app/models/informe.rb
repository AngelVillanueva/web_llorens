# == Schema Information
#
# Table name: informes
#
#  id               :integer          not null, primary key
#  matricula        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pdf_file_name    :string(255)
#  pdf_content_type :string(255)
#  pdf_file_size    :integer
#  pdf_updated_at   :datetime
#  identificador    :string(255)
#  organizacion_id  :integer
#  solicitante      :string(255)
#  cliente_id       :integer
#

class Informe < ActiveRecord::Base
  belongs_to :cliente
  has_attached_file :pdf
  default_scope order('pdf_content_type DESC, created_at DESC')
  
  validates :matricula, :solicitante, :cliente_id, presence: true
end
