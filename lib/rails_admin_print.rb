require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminPrint
end
 
module RailsAdmin
  module Config
    module Actions
      class Print < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do
          true
        end
        register_instance_option :link_icon do
          'icon-print'
        end
      end
    end
  end
end