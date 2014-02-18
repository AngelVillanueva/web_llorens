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
  let( :vehiculo ) { StockVehicle.new }

  it { should belong_to :cliente }
  it { should be_valid }
end
