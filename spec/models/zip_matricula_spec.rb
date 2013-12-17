# == Schema Information
#
# Table name: zip_matriculas
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  zip_file_name    :string(255)
#  zip_content_type :string(255)
#  zip_file_size    :integer
#  zip_updated_at   :datetime
#

require 'spec_helper'

describe ZipMatricula do
  let( :zip_matricula ) { FactoryGirl.create( :zip_matricula ) }
  subject { zip_matricula }

  it { should respond_to :zip }
  it { should respond_to :expandido }
  it { should validate_presence_of :zip }
  it { should be_valid }
end
