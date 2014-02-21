require 'spec_helper'

describe XmlVehicle do
  let( :xml_vehicle ) { FactoryGirl.create( :xml_vehicle ) }
  subject { xml_vehicle }

  it { should respond_to :xml }
  it { should belong_to :cliente }
  it { should validate_presence_of :xml }
  it { should validate_presence_of :cliente_id }
  it { should be_valid }
end