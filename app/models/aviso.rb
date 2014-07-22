# == Schema Information
#
# Table name: avisos
#
#  id                              :integer          not null, primary key
#  contenido                       :text
#  titular                         :string(255)
#  fecha_de_caducidad              :date
#  dias_visible_desde_ultimo_login :integer
#  created_at                      :datetime
#  updated_at                      :datetime
#  sorting_order                   :integer
#

class Aviso < ActiveRecord::Base
  has_many :notificaciones, dependent: :destroy
  has_many :usuarios, through: :notificaciones
  default_scope order( "sorting_order ASC, created_at DESC" )
  scope :vivos,  lambda{ where( "fecha_de_caducidad IS NULL OR fecha_de_caducidad > ?", Date.today ) }
  scope :caducados, lambda{ where( "fecha_de_caducidad < ?", Date.today ) }

  validates :contenido, presence: true

  after_create :create_notificaciones
  after_initialize do
    self.fecha_de_caducidad ||= 1.year.from_now
    self.dias_visible_desde_ultimo_login ||= 7
    self.sorting_order ||= 1
  end
  before_save :assign_default_values

  rails_admin do
    list do
      sort_by "sorting_order ASC, created_at"
      field :id
      field :sorting_order do
        label I18n.t( "Sorting order" )
      end
      field :created_at
      field :titular
      field :contenido do
        pretty_value do
          value.html_safe
        end
      end
      field :fecha_de_caducidad
      field :dias_visible_desde_ultimo_login do
        label I18n.t( "Dias visible corto")
      end
    end
    show do
      field :titular
      field :contenido do
        pretty_value do
          value.html_safe
        end
      end
      field :fecha_de_caducidad
      field :dias_visible_desde_ultimo_login do
        label I18n.t( "Dias visible corto")
      end
      field :sorting_order do
        label I18n.t( "Sorting order" )
      end
      field :usuarios
      field :notificaciones
    end
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :titular do
        help I18n.t( "Opcional o Aviso" )
      end
      field :contenido, :rich_editor do
        help I18n.t( "Requerido" )
      end
      field :sorting_order do
        label I18n.t( "Sorting order" )
        help I18n.t( "Order help" )
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

  def assign_default_values
    self.fecha_de_caducidad = 1.year.from_now if fecha_de_caducidad.nil?
    self.dias_visible_desde_ultimo_login = 7 if dias_visible_desde_ultimo_login.nil?
    self.sorting_order = 1 if sorting_order.nil?
  end

end
