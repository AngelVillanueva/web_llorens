# == Schema Information
#
# Table name: notificaciones
#
#  id                 :integer          not null, primary key
#  aviso_id           :integer
#  usuario_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  caducidad_relativa :date
#

class Notificacion < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :aviso
end
