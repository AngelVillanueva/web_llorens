# == Schema Information
#
# Table name: avisos
#
#  id        :integer          not null, primary key
#  contenido :text
#

class Aviso < ActiveRecord::Base
  has_many :notificaciones, dependent: :destroy
  has_many :usuarios, through: :notificaciones
  scope :vivos,  lambda{ where( "fecha_de_caducidad IS NULL OR fecha_de_caducidad > ?", Date.today ) }
  scope :caducados, lambda{ where( "fecha_de_caducidad < ?", Date.today ) }

  validates :contenido, presence: true

  after_create :create_notificaciones
  before_save :assign_caducidad

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
