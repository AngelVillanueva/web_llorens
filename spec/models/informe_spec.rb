# == Schema Information
#
# Table name: informes
#
#  id               :integer          not null, primary key
#  matricula        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  pdf_file_name    :string(255)
#  pdf_content_type :string(255)
#  pdf_file_size    :integer
#  pdf_updated_at   :datetime
#  identificador    :string(255)
#  organizacion_id  :integer
#  solicitante      :string(255)
#  cliente_id       :integer
#

require 'spec_helper'

describe Informe do
  let( :informe ) { Informe.new }
  
  describe "as a Model" do
    subject { informe }

    it { should respond_to :matricula }
    it { should respond_to :pdf }
    it { should respond_to :cliente }
    it { should respond_to :solicitante }
  end
  describe "with all fields being mandatory" do
    it "should validate presence of" do
      should validate_presence_of :matricula
      should validate_presence_of :solicitante
      should validate_presence_of :cliente_id
    end
  end
end
