require 'spec_helper'

describe Informe do
  let( :informe ) { Informe.new }
  describe "as a Model" do
    subject { informe }

    it { should respond_to :matricula }
    it { should respond_to :fecha_solicitud }
    it { should respond_to :pdf }
    it { should respond_to :organizacion }
    it { should respond_to :solicitante }
  end
end