# == Schema Information
#
# Table name: avisos
#
#  id                              :integer          not null, primary key
#  contenido                       :text
#  titular                         :string(255)
#  fecha_de_caducidad              :date
#  dias_visible_desde_ultimo_login :integer
#

class Aviso < ActiveRecord::Base
  has_many :notificaciones, dependent: :destroy
  has_many :usuarios, through: :notificaciones
  scope :vivos,  lambda{ where( "fecha_de_caducidad IS NULL OR fecha_de_caducidad > ?", Date.today ) }
  scope :caducados, lambda{ where( "fecha_de_caducidad < ?", Date.today ) }

  validates :contenido, presence: true

  after_create :create_notificaciones
  before_save :assign_caducidad

  rails_admin do
    list do
      field :id
      field :titular
      field :contenido
      field :fecha_de_caducidad
      field :dias_visible_desde_ultimo_login do
        label I18n.t( "Dias visible corto")
      end
    end
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :titular do
        help I18n.t( "Opcional o Aviso" )
      end
      field :contenido do
        help I18n.t( "Requerido" )
      end
      field :dias_visible_desde_ultimo_login do
        label I18n.t( "Dias visible" )
        help I18n.t( "Opcional 1 semana por defecto" )
      end
      field :fecha_de_caducidad do
        date_format :default
        help I18n.t( "Opcional 365 dias por defecto" )
      end
    end
  end

  protected
  def create_notificaciones
    Usuario.all.each do |u|
      self.usuarios << u
    end
  end

  def assign_caducidad
    self.fecha_de_caducidad = 1.year.from_now if fecha_de_caducidad.nil?
    self.dias_visible_desde_ultimo_login = 7 if dias_visible_desde_ultimo_login.nil?
  end

end
