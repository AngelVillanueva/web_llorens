# == Schema Information
#
# Table name: configurations
#
#  id         :integer          not null, primary key
#  option     :string(255)
#  enabled    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Configuration do
  let( :config_option ) { Configuration.new }

  it { should respond_to :enabled }
  it { should be_valid }
end
