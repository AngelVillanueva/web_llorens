# == Schema Information
#
# Table name: expedientes
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  matricula           :string(255)
#  bastidor            :string(255)
#  comprador           :text
#  vendedor            :text
#  marca               :string(255)
#  modelo              :string(255)
#  fecha_alta          :date
#  fecha_entra_trafico :date
#  fecha_facturacion   :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  observaciones       :text
#  type                :string(255)
#  cliente_id          :integer
#  llorens_cliente_id  :string(255)
#

require 'spec_helper'

describe Expediente do
  let( :expediente ) { FactoryGirl.create( :matriculacion ) }
  subject { expediente }
  
  describe "with valid attributes" do
    it { should respond_to :identificador }
    it { should respond_to :bastidor }
    it { should respond_to :matricula }
    it { should respond_to :comprador }
    it { should respond_to :vendedor }
    it { should respond_to :marca }
    it { should respond_to :modelo }
    it { should respond_to :fecha_alta }
    it { should respond_to :fecha_entra_trafico }
    it { should respond_to :fecha_facturacion }
    it { should respond_to :fecha_sale_trafico }
    it { should respond_to :dias_tramite }
    it { should respond_to :observaciones }
    it { should respond_to :type }
    it { should respond_to :llorens_cliente_id }
    it { should belong_to :cliente }

    it { should be_valid }
  end
  describe "with two types" do
    it { should respond_to :type }
  end
  describe "with all fields but observaciones being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :identificador
      should validate_presence_of :bastidor
      should validate_presence_of :matricula
      should validate_presence_of :comprador
      should validate_presence_of :vendedor
      should validate_presence_of :marca
      should validate_presence_of :modelo
      should validate_presence_of :fecha_alta
      should validate_presence_of :cliente_id
    end
  end
  
end
