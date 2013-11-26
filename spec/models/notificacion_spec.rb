require 'spec_helper'

describe Notificacion do
  describe "as a model" do
    it { should respond_to :caducidad_relativa }

    it { should be_valid }
  end
end