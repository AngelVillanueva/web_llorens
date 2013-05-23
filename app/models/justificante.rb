class Justificante < ActiveRecord::Base
  belongs_to :usuario
  has_attached_file :pdf

  validates :nif_comprador, :usuario_id, presence: true
end
