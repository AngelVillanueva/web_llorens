class AddColumnViewMandatoToOrganizacion < ActiveRecord::Migration
  def change
  	add_column :organizaciones, :view_mandato, :boolean, default: false
  end
end
