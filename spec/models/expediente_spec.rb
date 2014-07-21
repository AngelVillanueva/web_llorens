# == Schema Information
#
# Table name: expedientes
#
#  id                          :integer          not null, primary key
#  identificador               :string(255)
#  matricula                   :string(255)
#  bastidor                    :string(255)
#  comprador                   :text
#  vendedor                    :text
#  marca                       :string(255)
#  modelo                      :string(255)
#  fecha_alta                  :date
#  fecha_entra_trafico         :date
#  fecha_facturacion           :date
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  observaciones               :text
#  type                        :string(255)
#  cliente_id                  :integer
#  llorens_cliente_id          :string(255)
#  pdf_file_name               :string(255)
#  pdf_content_type            :string(255)
#  pdf_file_size               :integer
#  pdf_updated_at              :datetime
#  incidencia                  :text
#  has_incidencia              :boolean
#  has_documentos              :boolean          default(FALSE), not null
#  fecha_resolucion_incidencia :date
#

require 'spec_helper'

describe Expediente do
  let( :expediente ) { FactoryGirl.create( :matriculacion ) }
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
    it { should respond_to :dias_tramite }
    it { should respond_to :observaciones }
    it { should respond_to :incidencia }
    it { should respond_to :fecha_resolucion_incidencia }
    it { should respond_to :has_incidencia }
    it { should respond_to :has_documentos }
    it { should respond_to :type }
    it { should respond_to :llorens_cliente_id }
    it { should respond_to :ivtm }
    it { should belong_to :cliente }

    it { should be_valid }
  end
  describe "with two types" do
    it { should respond_to :type }
  end
  describe "with all fields but observaciones and incidencia being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :identificador
      should validate_presence_of :bastidor
      should validate_presence_of :comprador
      should validate_presence_of :marca
      should validate_presence_of :modelo
      should validate_presence_of :fecha_alta
      should validate_presence_of :cliente_id
    end
  end
  describe "for Matriculaciones" do
    it "should not have Vendedor as a mandatory field" do
      should_not validate_presence_of :vendedor
    end
  end
  describe "also for Transferencias" do
    let(:transferencia) { FactoryGirl.create( :transferencia ) }
    subject { transferencia }
    it "should not have Vendedor as a mandatory field" do
      should_not validate_presence_of :vendedor
    end
  end
  describe "for Matriculaciones" do
    it "should not have Matricula as a mandatory field" do
      should_not validate_presence_of :matricula
    end
  end
  describe "for Transferencias" do
    let(:transferencia) { FactoryGirl.create( :transferencia ) }
    subject { transferencia }
    it "should have Matricula as a mandatory field" do
      should validate_presence_of :matricula
    end
  end
  describe "for Matriculaciones" do
    it "should have PDF as an attribute" do
      should respond_to :pdf
    end
  end
  describe "for Transferencias" do
    let(:transferencia) { FactoryGirl.create( :transferencia ) }
    subject { transferencia }
    it "should not have pdf as an attribute" do
      should_not respond_to :pdf
    end
  end
  
end
