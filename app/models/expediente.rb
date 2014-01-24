# == Schema Information
#
# Table name: expedientes
#
#  id                          :integer          not null, primary key
#  identificador               :string(255)
#  matricula                   :string(255)
#  bastidor                    :string(255)
#  comprador                   :text
#  vendedor                    :text
#  marca                       :string(255)
#  modelo                      :string(255)
#  fecha_alta                  :date
#  fecha_entra_trafico         :date
#  fecha_facturacion           :date
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  observaciones               :text
#  type                        :string(255)
#  cliente_id                  :integer
#  llorens_cliente_id          :string(255)
#  pdf_file_name               :string(255)
#  pdf_content_type            :string(255)
#  pdf_file_size               :integer
#  pdf_updated_at              :datetime
#  incidencia                  :text
#  has_incidencia              :boolean
#  has_documentos              :boolean          default(FALSE), not null
#  fecha_resolucion_incidencia :date
#

class Expediente < ActiveRecord::Base
  belongs_to :cliente

  #before_validation :assign_internal_cliente_id
  before_save :check_incidencia!

  validates :identificador, :bastidor, :comprador, :marca, :modelo, :fecha_alta, :cliente_id, :type, presence: true

  def fecha_sale_trafico
    fecha_facturacion
  end

  def dias_tramite
    return nil if ( fecha_sale_trafico.nil? && fecha_alta.nil? )
    return "" if fecha_sale_trafico.nil?
    ( fecha_sale_trafico - fecha_alta ).to_i
  end

  def check_incidencia!
    if incidencia && !incidencia.empty?
      self.has_incidencia = true
    else
      self.has_incidencia = false
    end
    nil
  end

  # def assign_internal_cliente_id
  #   internal_cliente = Cliente.where(llorens_cliente_id: self.cliente_id.to_s).first
  #   self.cliente_id = internal_cliente.id 
  # end

  rails_admin do
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :identificador
      field :matricula
      field :bastidor
      field :cliente
      field :llorens_cliente_id do
        label I18n.t("llorens_cliente_id")
      end
      field :comprador
      field :vendedor do
        group :advanced
      end
      field :marca
      field :modelo
      field :fecha_alta do
        date_format :default
      end
      field :fecha_entra_trafico do
        date_format :default
        group :advanced
      end
      field :fecha_facturacion do
        date_format :default
        group :advanced
      end
      field :observaciones do
        group :advanced
      end
    end
  end
end
