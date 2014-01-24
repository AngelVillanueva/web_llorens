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
#  expandido        :boolean          default(FALSE)
#

class ZipMatricula < ActiveRecord::Base
  has_attached_file :zip,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  validates :zip, presence: true

  rails_admin do
    edit do
      field :zip do
        help I18n.t( "Formato matricula zip - ayuda" )
      end
    end
  end
  
end
