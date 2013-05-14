class InformeTrafico < ActiveRecord::Base
  attr_accessible :fecha_solicitud, :matricula, :solicitante
end
