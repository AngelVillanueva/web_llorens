class ApplicationController < ActionController::Base
  protect_from_forgery
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # override default Devise redirect after sign in
  def after_sign_in_path_for(resource_or_scope)
   stored_location_for(resource) || online_root_path
  end

  # CanCan customization
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end
  # CanCan access denied rescue
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    if current_usuario
      redirect_to main_app.root_path
    else
      redirect_to main_app.root_path
    end
  end

  # before_filter :authenticate_usuario!

  # def current_ability
  #   @current_ability ||= Ability.new(current_usuario)
  # end
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end
end
