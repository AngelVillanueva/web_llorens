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
#  solicitante      :string(255)
#  cliente_id       :integer
#

class Informe < ActiveRecord::Base
  belongs_to :cliente
  has_attached_file :pdf,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension",
    :url => "/online/informes/:id/download"
  default_scope includes(:cliente).order('pdf_content_type DESC, created_at DESC')

  after_create :send_email_if_out_of_the_office
  
  validates :matricula, :solicitante, :cliente_id, presence: true

  def send_email_if_out_of_the_office
    if informe_new_mailer?
      recipients = Guardia.pluck(:email)
      recipients.each do |r|
        WeekendMailer.delay.new_informe(r, cliente)
      end
    end
  end

  def informe_new_mailer?
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
    elsif (1..4).include?( created_at.to_date.wday ) && created_at.hour >= 19
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

  rails_admin do
    list do
      sort_by :pdf_file_name
      field :id
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
      field :created_at do
        label "Solicitado el"
        pretty_value do
          I18n.l( value, format: "%d/%m/%Y %H:%M" )
        end
      end
      field :pdf_updated_at do
        label "PDF subido el"
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          I18n.l( value, format: "%d/%m/%Y %H:%M" ) unless value.nil?
        end
      end
      field :solicitante
      field :updated_at
      field :cliente_id
      field :pdf_content_type
      field :pdf_file_size
      field :identificador
    end
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :matricula do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :solicitante do
        read_only do
          # controller bindings is available here. Example:
          bindings[:controller].current_usuario.role? "employee"
        end
      end
      field :cliente do
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
    end
  end
end
