class Justificante < ActiveRecord::Base
  attr_accessible :status, :bastidor, :comprador, :dias_tramite, :fecha_alta, :fecha_entra_trafico, :fecha_sale_trafico, :identificador, :marca, :matricula, :matriculacion, :modelo, :vendedor
end
