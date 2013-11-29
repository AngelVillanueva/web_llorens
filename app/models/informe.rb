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
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :matricula
      field :solicitante
      field :cliente
      field :pdf_file_name do
        label I18n.t("PDF file name")
        read_only true
        group :advanced
      end
      field :pdf, :paperclip do
        label I18n.t("PDF")
        group :advanced
      end
    end
  end
end
