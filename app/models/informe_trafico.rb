# == Schema Information
#
# Table name: informe_traficos
#
#  id              :integer          not null, primary key
#  matricula       :string(255)
#  solicitante     :text
#  fecha_solicitud :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :boolean
#

class InformeTrafico < ActiveRecord::Base
  attr_accessible :fecha_solicitud, :matricula, :solicitante, :status
end
