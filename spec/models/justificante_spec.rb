require 'spec_helper'

describe Justificante do
  let( :justificante ) { Justificante.new }
  subject { justificante }

  describe "as a Model" do
    it { should respond_to :identificador }
    it { should respond_to :nif_comprador }
    it { should respond_to :nombre_razon_social }
    it { should respond_to :primer_apellido }
    it { should respond_to :segundo_apellido }
    it { should respond_to :provincia }
    it { should respond_to :municipio }
    it { should respond_to :direccion }
    it { should respond_to :matricula }
    it { should respond_to :bastidor }
    it { should respond_to :marca }
    it { should respond_to :modelo }
    it { should respond_to :usuario }
  end
end
