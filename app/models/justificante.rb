class Justificante < ActiveRecord::Base
  belongs_to :usuario

  validates :nif_comprador, :usuario_id, presence: true
end
