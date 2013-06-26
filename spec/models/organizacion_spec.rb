# == Schema Information
#
# Table name: organizaciones
#
#  id            :integer          not null, primary key
#  nombre        :string(255)
#  identificador :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cif           :string(255)
#

require 'spec_helper'

describe Organizacion do
  let(:organizacion) { FactoryGirl.create(:organizacion) }
  subject { organizacion }
  
  describe "as a Model" do
    it { should respond_to :cif }
    it { should respond_to :nombre }
    it { should respond_to :identificador}
    it { should respond_to :clientes }
    it { should be_valid }
  end
  describe "with mandatory field nombre" do
    before do
      organizacion.nombre = nil
    end
    it { should_not be_valid }
  end
  describe "with mandatory field identificador" do
    before do
      organizacion.identificador = nil
    end
    it { should_not be_valid }
  end
  describe "with mandatory field cif" do
    before do
      organizacion.cif = nil
    end
    it { should_not be_valid }
  end
end
