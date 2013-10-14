class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
   administration_root_path
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  def check_auth
    redirect_to root_url, :alert => "Access denied" unless current_user.try(:admin?)
  end
end
