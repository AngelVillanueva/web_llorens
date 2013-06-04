class OnlineController < ApplicationController
  before_filter :authenticate_usuario!

  
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to online.root_url, :alert => exception.message
  end
end