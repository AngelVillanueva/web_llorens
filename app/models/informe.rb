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

  after_create :send_email_if_weekend
  
  validates :matricula, :solicitante, :cliente_id, presence: true

  def send_email_if_weekend
    if [0,6].include? created_at.to_date.wday
      WeekendMailer.delay.new_informe
    end
  end

  rails_admin do
    list do
      sort_by :pdf_file_name
      field :id
      field :matricula
      field :pdf_file_name do
        sort_reverse true
        pretty_value do
          css_class("empty#{value.to_s[0]}")
          value
        end
      end
      field :created_at do
        label "Solicitado el"
      end
      field :solicitante
      field :identificador
      field :updated_at
      field :cliente_id
      field :pdf_content_type
      field :pdf_file_size
      field :pdf_updated_at
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
