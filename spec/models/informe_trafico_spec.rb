require 'spec_helper'

describe InformeTrafico do
  let( :informe ) { InformeTrafico.new }
  describe "as a Model" do
    subject { informe }

    it { should respond_to :matricula }
    it { should respond_to :fecha_solicitud }
    it { should respond_to :pdf }
    it { should respond_to :usuario }
    it { should respond_to :organizacion }
  end
end