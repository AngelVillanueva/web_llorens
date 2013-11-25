# == Schema Information
#
# Table name: usuarios
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nombre                 :string(255)
#  apellidos              :string(255)
#  organizacion_id        :integer
#  role                   :string(255)
#  password_changed_at    :datetime
#

class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :password_expirable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  belongs_to :organizacion
  has_and_belongs_to_many :clientes
  has_many :notificaciones
  has_many :avisos, through: :notificaciones

  validates :nombre, :apellidos, :organizacion_id, presence: true
  validate :clientes_from_same_organizacion

  def role_enum
    %w[admin employee]
  end

  def role?(role)
   self.role == role.to_s
  end

  def norole?
    self.role.nil? || self.role.empty?
  end

  def expedientes
    Expediente.where(cliente_id: clientes)
  end
  def justificantes
    Justificante.where(cliente_id: clientes)
  end
  def informes
    Informe.where(cliente_id: clientes)
  end

  # delete all notificaciones already expired after successful login
  def after_database_authentication
    return unless self.norole?
    self.avisos.caducados.each do |aviso_caducado|
      notificacion_caducada = Notificacion.where("usuario_id = ? AND aviso_id = ?", self.id, aviso_caducado.id)
      notificacion_caducada.delete_all
    end
  end

  rails_admin do
    edit do
      group :advanced do
        label I18n.t("Advanced")
        active false
      end
      field :nombre
      field :apellidos
      field :email
      field :password do
        label I18n.t("Password")
      end
      field :organizacion
      field :clientes
      field :role do
        label I18n.t("Role")
        group :advanced
      end
      field :password_changed_at do
        label I18n.t("Password changed at")
        group :advanced
      end
    end
  end

  private
  def clientes_from_same_organizacion
    #errors.add(:usuarios, 'No pertenecen a la misma Organizacion') if organizacion_id !== cliente.organizacion_id
    clientes.each do |cliente|
      if organizacion_id != cliente.organizacion_id
        errors.add(:usuarios, "No pertenecen a la misma Organizacion")
      end
    end
  end
end
