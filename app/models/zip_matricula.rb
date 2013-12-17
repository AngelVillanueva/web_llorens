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

class ZipMatricula < ActiveRecord::Base
  has_attached_file :zip,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  #before_create :generate_access_token
  
private
  
  # def generate_access_token
  #   begin
  #     self.access_token = SecureRandom.hex
  #   end while self.class.exists?(access_token: access_token)
  # end
end
