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
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pdf                 :string(255)
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#  hora_solicitud      :datetime
#  hora_entrega        :datetime
#  cliente_id          :integer
#

class Justificante < ActiveRecord::Base
  belongs_to :cliente
  has_attached_file :pdf,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension",
    :url => "/online/justificantes/:id/download"
  default_scope includes(:cliente).order('created_at DESC')

  before_validation :assign_hora_solicitud, on: :create
  before_update :assign_hora_entrega, if: :first_time_pdf?

  validates :identificador, :nif_comprador, :nombre_razon_social, :primer_apellido, :segundo_apellido, :provincia, :municipio, :direccion, :matricula, :bastidor, :marca, :modelo, :hora_solicitud, :cliente_id, presence: true

  #protected
  def assign_hora_solicitud
    self.hora_solicitud = Time.now
  end
  def assign_hora_entrega
    self.hora_entrega = Time.now
  end
  def first_time_pdf?
    pdf_file_name_was.nil? && !pdf_file_name.nil?
  end

  rails_admin do
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :identificador
      field :matricula
      field :bastidor
      field :marca
      field :modelo
      field :nif_comprador
      field :nombre_razon_social
      field :primer_apellido
      field :segundo_apellido
      field :direccion
      field :municipio
      field :provincia
      field :pdf_file_name do
        label I18n.t("PDF file name")
        read_only true
        group :advanced
      end
      field :pdf, :paperclip do
        label I18n.t("PDF")
        group :advanced
      end
      field :cliente
      field :hora_solicitud do
        date_format :default
      end
      field :hora_entrega do
        date_format :default
        group :advanced
      end
    end
  end
end
