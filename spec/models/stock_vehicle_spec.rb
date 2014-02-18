require 'spec_helper'

describe StockVehicle do
  let( :vehiculo ) { StockVehicle.new }

  it { should belong_to :cliente }
  it { should be_valid }
end