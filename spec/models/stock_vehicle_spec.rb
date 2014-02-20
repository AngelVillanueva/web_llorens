# == Schema Information
#
# Table name: stock_vehicles
#
#  id         :integer          not null, primary key
#  matricula  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cliente_id :integer
#

require 'spec_helper'

describe StockVehicle do
  let( :vehiculo ) { FactoryGirl.create( :stock_vehicle ) }
  subject { vehiculo }

  it { should respond_to :matricula }
  it { should validate_presence_of :matricula }
  it { should validate_uniqueness_of :matricula }
  it { should belong_to :cliente }
  it { should be_valid }
end
