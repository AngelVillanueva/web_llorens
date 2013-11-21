require 'spec_helper'

describe Aviso do
  let( :aviso ) { FactoryGirl.create( :aviso ) }
  subject { aviso }

  describe "with valid attributes" do
    it { should respond_to :titular }
    it { should respond_to :contenido }

    it { should be_valid }
  end

  describe "with mandatory fields" do
    it { should validate_presence_of :contenido }
  end
end