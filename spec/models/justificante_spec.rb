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
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#  organizacion_id     :integer
#  hora_solicitud      :datetime
#  hora_entrega        :datetime
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
    it { should respond_to :organizacion }
    it { should be_valid }
  end
  describe "with all fields but observaciones being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :identificador
      should validate_presence_of :nif_comprador
      should validate_presence_of :nombre_razon_social
      should validate_presence_of :primer_apellido
      should validate_presence_of :segundo_apellido
      should validate_presence_of :provincia
      should validate_presence_of :municipio
      should validate_presence_of :direccion
      should validate_presence_of :matricula
      should validate_presence_of :bastidor
      should validate_presence_of :marca
      should validate_presence_of :modelo
      should validate_presence_of :hora_solicitud
      should validate_presence_of :organizacion_id
    end
  end
  describe "with auto assigned hora_entrega field" do
    its( :hora_solicitud ) { should_not be_nil }
  end
end
