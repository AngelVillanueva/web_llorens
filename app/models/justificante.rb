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
  default_scope includes(:cliente).order('pending_pdf DESC, updated_at DESC')

  before_validation :assign_hora_solicitud, on: :create
  before_save :check_pdf!
  before_update :assign_hora_entrega, if: :first_time_pdf?
  after_create :send_email_if_out_of_the_office

  validates :identificador, :nif_comprador, :nombre_razon_social, :provincia, :municipio, :direccion, :matricula, :bastidor, :marca, :modelo, :hora_solicitud, :cliente_id, presence: true
  validates :nif_comprador, nif: true
  validates_format_of :municipio, :with => /^[[:alpha:]\s'"\-_&@!?()\[\]-]*$/u, :on => :create, :message => I18n.t( "Municipio sin numeros" )

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
  def send_email_if_out_of_the_office
    if justificante_new_mailer?
      recipients = Guardia.pluck(:email)
      recipients.each do |r|
        WeekendMailer.delay.new_justificante(r, cliente)
      end
    end
  end
  def justificante_new_mailer?
    # send if out_of_the_office enabled
    if configuration_check? "Emails de Guardia permanentes"
      true
    # else send if weekend (sunday, saturday)
    elsif [0,6].include? created_at.to_date.wday
      true
    # else send if friday from 5 pm
    elsif created_at.to_date.wday == 5 && created_at.hour >= 17
      true
    # else send if monday-thursday from 7 pm
    elsif (1..4).include?( created_at.to_date.wday ) && created_at.hour >= 17
      true
    # otherwise do not send the email
    else
      false
    end
  end

  def configuration_check? option
    o = Configuration.find_or_create_by_option( option )
    o.enabled?
  end

  def check_pdf!
    pdf_file_name.nil? ? self.pending_pdf = true : self.pending_pdf = false
    nil
  end

  rails_admin do
    list do
      sort_by :pdf_file_name, :hora_solicitud
      field :id
      field :identificador
      field :matricula do
        pretty_value do
          value.upcase
        end
      end
      field :pdf_file_name do
        sort_reverse true
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          value
        end
      end
      field :hora_solicitud do
        sort_reverse false
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M")
        end
      end
      field :hora_entrega do
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          I18n.l( value, format: "%d/%m/%Y %H:%M") unless value.nil?
        end
      end
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
      field :cliente
    end
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :identificador do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :matricula do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :pdf, :paperclip do
        label I18n.t("PDF")
      end
      field :pdf_file_name do
        label I18n.t("PDF file name")
        read_only true
      end
      field :bastidor do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :marca do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :modelo do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :nif_comprador do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :nombre_razon_social do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :primer_apellido do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :segundo_apellido do
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
      field :municipio do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :provincia do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :cliente do
        group :advanced
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :hora_solicitud do
        group :advanced
        date_format :default
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :hora_entrega do
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
