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
#  organizacion_id     :integer
#  type                :string(255)
#

require 'spec_helper'

describe Expediente do
  let(:expediente) { Expediente.new }
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
    it { should respond_to :identificador }
    it { should respond_to :dias_tramite }
    it { should respond_to :organizacion }

    it { should be_valid }
  end
  describe "with two types" do
    it { should respond_to :type }
  end
end
