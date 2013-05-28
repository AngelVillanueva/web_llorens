# == Schema Information
#
# Table name: organizacions
#
#  id            :integer          not null, primary key
#  nombre        :string(255)
#  identificador :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Organizacion do
  describe "as a Model" do
    let(:organizacion) { Organizacion.new }
    subject { organizacion }

    it { should respond_to :cif }
    it { should respond_to :nombre }
    it { should respond_to :identificador}
    it { should respond_to :usuarios }
    it { should respond_to :expedientes }
    it { should respond_to :justificantes }
    it { should respond_to :informes }
    it { should be_valid }
  end
end
