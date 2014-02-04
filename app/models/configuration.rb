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

  rails_admin do
    navigation_label I18n.t( "GLOBAL OPTIONS" )
    list do
      field :id
      field :option do
        label I18n.t( "Option" )
      end
      field :enabled do
        label I18n.t( "Enabled" )
      end
      field :created_at do
        label I18n.t( "Created" )
      end
      field :updated_at do
        label I18n.t( "Updated" )
      end
    end
    edit do
    end
  end
end
