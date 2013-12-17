# == Schema Information
#
# Table name: guardias
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Guardia do
  let( :guardia ) { FactoryGirl.create( :guardia ) }
  subject { guardia }

  it { should be_valid }
  it { should validate_presence_of( :email ) }
  it { should validate_uniqueness_of( :email ) }
  it { should_not allow_value( "test@test" ).for( :email ) }
end
