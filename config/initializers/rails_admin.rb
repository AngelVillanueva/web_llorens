# RailsAdmin config file. Generated on June 13, 2013 02:36
# See github.com/sferik/rails_admin for more informations
require Rails.root.join('lib', 'rails_admin_print.rb')
require Rails.root.join('lib', 'rails_admin_assign_zips.rb')
require Rails.root.join('lib', 'rails_admin_read_xml.rb')

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Web Llorens', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_usuario } # auto-generated

  # Can Can initializer
  config.authorize_with :cancan, AdminAbility

  # If you want to track changes on your models:
  # config.audit_with :history, 'Usuario'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'Usuario'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Expediente', 'Informe', 'Justificante', 'Matriculacion', 'Organizacion', 'Transferencia', 'Usuario']

  # Include specific models (exclude the others):
  # config.included_models = ['Expediente', 'Informe', 'Justificante', 'Matriculacion', 'Organizacion', 'Transferencia', 'Usuario']

  # Label methods for model instances:
  config.label_methods << :nombre # Default is [:name, :title]

  # register custom 'print', 'assign_zips' and 'process_xmls' actions
  config.actions do
    dashboard
    index
    new
    show
    print do
      visible do
        # Make it visible only for Justificantes + Informes model.
        bindings[:abstract_model].model.to_s.in? %w[Justificante Informe]
      end
    end
    assign_zips do
      visible do
        # Make it visible only for ZipMatricula model.
        bindings[:abstract_model].model.to_s.in? %w[ZipMatricula]
      end
    end
    read_xml do
      visible do
        # Make it visible only for XmlVehicle model.
        bindings[:abstract_model].model.to_s.in? %w[XmlVehicle]
      end
    end
    edit
    delete
  end

  # config.publish do
  #   # Make it visible only for Justificantes + Informes model.
  #   bindings[:abstract_model].model.to_s == "Justificante"
  # end


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:


  ###  Expediente  ###

  # config.model 'Expediente' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your expediente.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :identificador, :string 
  #     configure :matricula, :string 
  #     configure :bastidor, :string 
  #     configure :comprador, :text 
  #     configure :vendedor, :text 
  #     configure :marca, :string 
  #     configure :modelo, :string 
  #     configure :fecha_alta, :date 
  #     configure :fecha_entra_trafico, :date 
  #     configure :fecha_facturacion, :date 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :observaciones, :text 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Informe  ###

  # config.model 'Informe' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your informe.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :matricula, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :pdf_file_name, :string         # Hidden 
  #     configure :pdf_content_type, :string         # Hidden 
  #     configure :pdf_file_size, :integer         # Hidden 
  #     configure :pdf_updated_at, :datetime         # Hidden 
  #     configure :pdf, :paperclip 
  #     configure :identificador, :string 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :solicitante, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Justificante  ###

  # config.model 'Justificante' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your justificante.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :identificador, :string 
  #     configure :nif_comprador, :string 
  #     configure :nombre_razon_social, :string 
  #     configure :primer_apellido, :string 
  #     configure :segundo_apellido, :string 
  #     configure :provincia, :string 
  #     configure :municipio, :string 
  #     configure :codpostal, :string 
  #     configure :direccion, :text 
  #     configure :matricula, :string 
  #     configure :bastidor, :string 
  #     configure :marca, :string 
  #     configure :modelo, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :pdf, :string 
  #     configure :pdf_file_name, :string         # Hidden 
  #     configure :pdf_content_type, :string         # Hidden 
  #     configure :pdf_file_size, :integer         # Hidden 
  #     configure :pdf_updated_at, :datetime         # Hidden 
  #     configure :pdf, :paperclip 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :hora_solicitud, :datetime 
  #     configure :hora_entrega, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Matriculacion  ###

  # config.model 'Matriculacion' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your matriculacion.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :identificador, :string 
  #     configure :matricula, :string 
  #     configure :bastidor, :string 
  #     configure :comprador, :text 
  #     configure :vendedor, :text 
  #     configure :marca, :string 
  #     configure :modelo, :string 
  #     configure :fecha_alta, :date 
  #     configure :fecha_entra_trafico, :date 
  #     configure :fecha_facturacion, :date 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :observaciones, :text 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Organizacion  ###

  # config.model 'Organizacion' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your organizacion.rb model definition

  #   # Found associations:

  #     configure :usuarios, :has_many_association 
  #     configure :expedientes, :has_many_association 
  #     configure :justificantes, :has_many_association 
  #     configure :informes, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :nombre, :string 
  #     configure :identificador, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :cif, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Transferencia  ###

  # config.model 'Transferencia' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your transferencia.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :identificador, :string 
  #     configure :matricula, :string 
  #     configure :bastidor, :string 
  #     configure :comprador, :text 
  #     configure :vendedor, :text 
  #     configure :marca, :string 
  #     configure :modelo, :string 
  #     configure :fecha_alta, :date 
  #     configure :fecha_entra_trafico, :date 
  #     configure :fecha_facturacion, :date 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :observaciones, :text 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :type, :string 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Usuario  ###

  # config.model 'Usuario' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your usuario.rb model definition

  #   # Found associations:

  #     configure :organizacion, :belongs_to_association 
  #     configure :justificantes, :has_many_association 
  #     configure :informes, :has_many_association 

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :nombre, :string 
  #     configure :apellidos, :string 
  #     configure :organizacion_id, :integer         # Hidden 
  #     configure :role, :enum 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
