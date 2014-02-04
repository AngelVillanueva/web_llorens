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

class Configuration < ActiveRecord::Base
end
