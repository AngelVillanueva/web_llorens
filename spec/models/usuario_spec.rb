require 'spec_helper'

describe Usuario do
  describe "as a Model" do
    usuario = Usuario.new
    subject { usuario }

    it { should respond_to :nombre }
    it { should respond_to :apellidos }
    it { should respond_to :organizacion }
    it { should respond_to :identificador_organizacion}
    it { should respond_to :email }
    it { should respond_to :password }
  end
end
