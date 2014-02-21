class XmlVehicle < ActiveRecord::Base
  has_attached_file :xml,
    :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  belongs_to :cliente
  validates :xml, :cliente_id, presence: true

  rails_admin do
    navigation_label I18n.t( "REMARKETING")
    label I18n.t( "Athlon files")
    edit do
      field :xml do
        label I18n.t( "XML - label" )
        help I18n.t( "Formato athlon xml - ayuda" )
      end
      field :cliente_id, :hidden do
        default_value do
          Cliente.where(llorens_cliente_id: "4300189329").first.id
        end
      end
    end
  end
end