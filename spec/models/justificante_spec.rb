# == Schema Information
#
# Table name: justificantes
#
#  id                  :integer          not null, primary key
#  identificador       :string(255)
#  nif_comprador       :string(255)
#  nombre_razon_social :string(255)
#  primer_apellido     :string(255)
#  segundo_apellido    :string(255)
#  provincia           :string(255)
#  municipio           :string(255)
#  direccion           :text
#  matricula           :string(255)
#  bastidor            :string(255)
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
#

require 'spec_helper'

describe Justificante do
  let( :justificante ) { FactoryGirl.create( :justificante ) }
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
    it { should respond_to :hora_solicitud }
    it { should respond_to :hora_entrega }
    it { should respond_to :pdf }
    it { should respond_to :pending_pdf? }
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
      should validate_presence_of :provincia
      should validate_presence_of :municipio
      should validate_presence_of :direccion
      should validate_presence_of :matricula
      should validate_presence_of :bastidor
      should validate_presence_of :marca
      should validate_presence_of :modelo
      should validate_presence_of :hora_solicitud
      should validate_presence_of :cliente_id
    end
  end
  describe "with auto assigned hora_solicitud field" do
    its( :hora_solicitud ) { should_not be_nil }
  end
  describe "with auto assigned hora_entrega the first time a PDF is set" do
    before do
      justificante.update_attributes({ pdf_file_name: "my_pdf.pdf" })
    end
    its( :hora_entrega ) { should_not be_nil }
  end
  describe "with no modified hora_entrega when a different field thant PDF is updated" do
    before do
      justificante.update_attributes({ marca: "BMW" })
    end
    its( :hora_entrega ) { should be_nil }
  end
  describe "with no modified hora_entrega when a PDF already exists" do
    before do
      justificante.update_attributes({ pdf_file_name: "my_pdf.pdf" })
    end
    it "should not change" do
      expect{ justificante.update_attributes( { pdf_file_name: "o.pdf" } ) }.to_not change{ justificante }
    end
  end
  describe "with valid Municipio name on creation" do
    it "should not be numbers" do
      expect { FactoryGirl.create( :justificante, municipio: "123" ) }.to raise_exception
    end
    it "should not contain numbers" do
      expect { FactoryGirl.create( :justificante, municipio: "Abr3" ) }.to raise_exception
    end
  end
  describe "with default scope based on pending pdfs and updated time" do
    let(:j1) { FactoryGirl.create(:justificante) }
    let(:j2) { FactoryGirl.create(:justificante) }
    let(:j3) { FactoryGirl.create(:justificante) }
    let(:a_pdf) { File.new( "#{Rails.root}/spec/fixtures/test-J.pdf" ) }
    let(:other_pdf) { File.new( "#{Rails.root}/spec/fixtures/test-I.pdf" ) }
    it "should sort pending Justificantes first" do
      j1.pdf = other_pdf
      j1.save!
      j2.pdf = a_pdf
      j2.save!
      j3.save!
      Justificante.first.pending_pdf.should eql true
      Justificante.last.pending_pdf.should eql false
      Justificante.first.should eql j3
      Justificante.last.should eql j1
    end
    it "should sort not pending Justificantes by updated time" do
      j2.pdf = a_pdf
      j2.save!
      j3.save!
      j1.save!
      Justificante.first.pending_pdf.should eql true
      Justificante.last.pending_pdf.should eql false
      Justificante.first.should eql j1
      Justificante.last.should eql j2
    end
  end
end
