require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminPrint
end

# There are several options that you can set here. Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info. 
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
        register_instance_option :bulkable? do
          true
        end
        register_instance_option :controller do
          Proc.new do
            # selected ids in params[:bulk_ids]
            # class in params[:model_name]
          end
        end
      end
    end
  end
end