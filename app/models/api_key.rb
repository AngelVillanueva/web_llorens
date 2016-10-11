# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  access_token :string(255)
#  cliente_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ApiKey < ActiveRecord::Base
  belongs_to :cliente
  before_create :generate_access_token
  
private
  
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

rails_admin do
    list do
      field :access_token
      field :cliente
    end
    edit do
      field :access_token
      field :cliente
    end
  end
end

