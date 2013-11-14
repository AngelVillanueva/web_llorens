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

require 'spec_helper'

describe Usuario do
  let( :usuario ) { FactoryGirl.create( :usuario, organizacion_id: 1 ) }
  subject { usuario }

  describe "as a Model" do
    it { should respond_to :nombre }
    it { should respond_to :apellidos }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :expedientes }
    it { should respond_to :justificantes }
    it { should respond_to :informes }
    it { should respond_to :clientes }
    it { should respond_to :role }
    it { should respond_to :role? }
    it { should respond_to :norole? }
    it { should respond_to :organizacion }
    it { should be_valid }
  end
  describe "with several fields being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :email
      should validate_presence_of :nombre
      should validate_presence_of :apellidos
      should validate_presence_of :organizacion_id
    end
  end
  describe "with all her Clientes belonging to the same organizacion" do
    before do
      cliente = FactoryGirl.create( :cliente )
      usuario.organizacion_id = cliente.id.to_i + 1
      usuario.clientes << cliente
    end
    it { should_not be_valid }
  end
  specify 'associations should not be stored' do
    # reload group from DB to make sure that
    # invalid associations have not been stored
    subject.reload
    expect(subject.clientes).to eql( [] )
    expect(usuario.clientes.count).to eql( 0 )
  end
end
