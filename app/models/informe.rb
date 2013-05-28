# == Schema Information
#
# Table name: informes
#
#  id              :integer          not null, primary key
#  matricula       :string(255)
#  solicitante     :text
#  fecha_solicitud :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :boolean
#

class Informe < ActiveRecord::Base
  has_attached_file :pdf
  belongs_to :organizacion

  def fecha_solicitud
    created_at.to_date
  end
end
