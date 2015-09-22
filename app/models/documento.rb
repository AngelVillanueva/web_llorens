# == Schema Information
#
# Table name: documentos
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  bastidor            :string(255)
#  ficha_tecnica       :boolean
#  concesinario        :string(255)
#  fecha_recepcion     :datetime
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#  upload_pdf          :boolean
#  download_pdf        :boolean
#  observaciones       :text
#

class Documento < ActiveRecord::Base
  belongs_to :cliente
  has_attached_file :pdf,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension",
    :url => "/online/documentos/:id/downdoc/"
  default_scope includes(:cliente).order('upload_pdf DESC, download_pdf DESC, updated_at DESC')

  before_validation :assign_fecha_recepcion, on: :create
  before_create :assign_pdf_subido, if: :pdf_uploaded?
  before_update :assign_pdf_subido, if: :pdf_uploaded?
  # after_create :send_email_if_out_of_the_office

  validates :identificador, :bastidor, :concesionario, :fecha_recepcion, presence: true

  #protected
  def assign_fecha_recepcion
    self.fecha_recepcion = Time.now
  end
  def pdf_uploaded?
    !pdf_file_name.nil?
  end
  def assign_pdf_subido
    self.upload_pdf = true
  end

  def configuration_check? option
    o = Configuration.find_or_create_by_option( option )
    o.enabled?
  end

  rails_admin do
    list do
      sort_by :pdf_file_name, :fecha_recepcion
      field :id
      field :identificador
      field :bastidor
      field :ficha_tecnica
      field :concesionario
      field :pdf_file_name do
        sort_reverse true
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          value
        end
      end
      field :fecha_recepcion do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
      field :pdf_updated_at do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
      field :upload_pdf
      field :download_pdf
      field :observaciones
    end
    show do
      field :bastidor
      field :ficha_tecnica
      field :concesionario
      field :observaciones
    end 
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :bastidor do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :ficha_tecnica do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :concesionario do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :observaciones do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :fecha_recepcion do
        date_format :default
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
    end
  end
end
