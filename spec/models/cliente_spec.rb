# == Schema Information
#
# Table name: clientes
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)
#  identificador      :string(255)
#  cif                :string(255)
#  organizacion_id    :integer
#  llorens_cliente_id :string(255)
#

require 'spec_helper'

describe Cliente do
  let( :cliente ) { Cliente.new }
  subject { cliente }

  describe "as a Model" do
    it { should respond_to :nombre }
    it { should respond_to :identificador }
    it { should respond_to :cif }
    it { should belong_to :organizacion }
  end
  describe "with all fields being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :nombre
      should validate_presence_of :identificador
      should validate_presence_of :cif
      should validate_presence_of :llorens_cliente_id
      should validate_presence_of :organizacion_id
    end
  end
end
