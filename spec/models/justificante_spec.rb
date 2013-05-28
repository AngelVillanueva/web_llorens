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
#  usuario_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pdf_file_name       :string(255)
#  pdf_content_type    :string(255)
#  pdf_file_size       :integer
#  pdf_updated_at      :datetime
#

require 'spec_helper'

describe Justificante do
  let( :justificante ) { Justificante.new }
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
  end
end
