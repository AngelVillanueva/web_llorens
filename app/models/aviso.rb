# == Schema Information
#
# Table name: avisos
#
#  id        :integer          not null, primary key
#  contenido :text
#

class Aviso < ActiveRecord::Base
  has_many :notificaciones
  has_many :usuarios, through: :notificaciones
  scope :vivos,  lambda{ where("fecha_de_caducidad IS NULL OR fecha_de_caducidad > ?", Date.today ) }

  validates :contenido, presence: true

  after_create :create_notificaciones

  protected
  def create_notificaciones
    Usuario.all.each do |u|
      self.usuarios << u
    end
  end

end
