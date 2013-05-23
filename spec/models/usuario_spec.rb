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
#

require 'spec_helper'

describe Usuario do
  usuario = Usuario.new
  usuario.email = "foo@bar.com"
  usuario.password = "foobarfoo"
  describe "as a Model" do
    subject { usuario }

    it { should respond_to :nombre }
    it { should respond_to :apellidos }
    it { should respond_to :organizacion }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :expedientes }
    it { should respond_to :justificantes }
    it { should be_valid }
  end
end
