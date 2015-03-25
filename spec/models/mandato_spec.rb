# == Schema Information
#
# Table name: mandatos
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  nif_comprador       :string(255)
#  nombre_razon_social :string(255)
#  primer_apellido     :string(255)
#  segundo_apellido    :string(255)
#  repre_nombre        :string(255)
#  repre_apellido_1    :string(255)
#  repre_apellido_2    :string(255)
#  nif_representante   :string(255)
#  provincia           :string(255)
#  municipio           :string(255)
#  direccion           :text
#  telefono            :string(255)
#  matricula_bastidor  :string(255)
#  marca               :string(255)
#  modelo              :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pdf                 :string(255)
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#  hora_solicitud      :datetime
#  hora_entrega        :datetime
#  cliente_id          :integer
#  secure_token        :string(255)
#  pending_code        :boolean
#

require 'spec_helper'

describe Mandato do
  let( :mandato ) { FactoryGirl.create( :mandato ) }
  subject { mandato }

  describe "as a Model" do
    it { should respond_to :identificador }
    it { should respond_to :nif_comprador }
    it { should respond_to :nombre_razon_social }
    it { should respond_to :primer_apellido }
    it { should respond_to :segundo_apellido }
    it { should respond_to :repre_nombre }
    it { should respond_to :repre_apellido_1 }
    it { should respond_to :repre_apellido_2 }
    it { should respond_to :nif_representante }
    it { should respond_to :provincia }
    it { should respond_to :municipio }
    it { should respond_to :direccion }
    it { should respond_to :telefono }
    it { should respond_to :matricula_bastidor }
    it { should respond_to :marca }
    it { should respond_to :modelo }
    it { should respond_to :hora_solicitud }
    it { should respond_to :hora_entrega }
    it { should respond_to :pdf }
    it { should respond_to :pending_code? }
    it { should respond_to :secure_token }
    it { should respond_to :cliente }
    it { should be_valid }
  end
  describe "with all fields but observaciones being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :identificador
      should validate_presence_of :nif_comprador
      should validate_presence_of :nombre_razon_social
      should_not validate_presence_of :primer_apellido
      should_not validate_presence_of :segundo_apellido
      should_not validate_presence_of :repre_nombre
      should_not validate_presence_of :repre_apellido_1
      should_not validate_presence_of :repre_apellido_2
      should_not validate_presence_of :nif_representante
      should validate_presence_of :provincia
      should validate_presence_of :municipio
      should validate_presence_of :direccion
      should validate_presence_of :telefono
      should validate_presence_of :matricula_bastidor
      should validate_presence_of :marca
      should validate_presence_of :modelo
      should validate_presence_of :hora_solicitud
      should validate_presence_of :secure_token
      should validate_presence_of :cliente_id
    end
  end
  describe "with auto assigned hora_solicitud field" do
    its( :hora_solicitud ) { should_not be_nil }
  end
  describe "with auto assigned secure_token field" do
    its( :secure_token ) { should_not be_nil }
  end
  describe "with auto assigned hora_entrega the first time a PDF is set" do
    before do
      mandato.update_attributes({ pdf_file_name: "my_pdf.pdf" })
    end
    its( :hora_entrega ) { should_not be_nil }
  end
  describe "with no modified hora_entrega when a different field thant PDF is updated" do
    before do
      mandato.update_attributes({ marca: "BMW" })
    end
    its( :hora_entrega ) { should be_nil }
  end
  describe "with no modified hora_entrega when a PDF already exists" do
    before do
      mandato.update_attributes({ pdf_file_name: "my_pdf.pdf" })
    end
    it "should not change" do
      expect{ mandato.update_attributes( { pdf_file_name: "o.pdf" } ) }.to_not change{ mandato }
    end
  end
  describe "with valid Municipio name on creation" do
    it "should not be numbers" do
      expect { FactoryGirl.create( :mandato, municipio: "123" ) }.to raise_exception
    end
    it "should not contain numbers" do
      expect { FactoryGirl.create( :mandato, municipio: "Abr3" ) }.to raise_exception
    end
  end
end
