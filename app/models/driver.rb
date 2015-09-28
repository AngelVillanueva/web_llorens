# == Schema Information
#
# Table name: drivers
#
#  id                    :integer          not null, primary key
#  identificador         :string(255)
#  matricula             :string(255)
#  bastidor              :string(255)
#  fecha_matriculacion   :datetime
#  envio_ok              :boolean
#  fecha_envio           :datetime
#  concesionario_cliente :boolean
#  direccion             :string(255)
#  persona_contacto      :string(255)
#  pdf_file_name         :string(255)
#  pdf_content_type      :string(255)
#  pdf_file_size         :integer
#  pdf_updated_at        :datetime
#

class Driver < ActiveRecord::Base
  belongs_to :cliente
  has_attached_file :pdf,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension",
    :url => "/online/drivers/:id/download"
  default_scope includes(:cliente).order('envio_ok DESC, updated_at DESC')

  before_update :assign_fecha_envio, if: :envio_to_ok?
  # after_create :send_email_if_out_of_the_office

  validates :identificador, :matricula, :bastidor, :fecha_matriculacion, presence: true
  validates :bastidor, uniqueness: true

  #protected
  def envio_to_ok?
    !envio_ok.nil?
  end
  def assign_fecha_envio
    self.fecha_envio = Time.now
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
      field :matricula
      field :bastidor
      field :fecha_matriculacion do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
      field :envio_ok
      field :fecha_envio do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
      field :concesionario_cliente
      field :direccion
      field :persona_contacto
      field :pdf_file_name do
        sort_reverse true
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          value
        end
      end
      field :pdf_updated_at do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
    end
    show do
      field :matricula
      field :bastidor
      field :fecha_matriculacion do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
    end 
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :envio_ok do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :concesionario_cliente do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :direccion do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :persona_contacto do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
    end
  end
end
