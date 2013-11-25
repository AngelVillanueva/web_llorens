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

  validates :contenido, presence: true

  after_save :create_notificaciones

  protected
  def create_notificaciones
    Usuario.all.each do |u|
      self.usuarios << u
    end
  end
end
